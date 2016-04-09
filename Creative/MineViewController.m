//
//  MineViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MineViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MineBasicView.h"
#import "WUserInFo.h"
#import "NewsViewController.h"
#import "Education.h"

#define ImgH    30
#define Height  30
#define LineH   0.5
#define LineW   self.view.mj_w - 33

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    BOOL            *_flag;
    NSString *btnT;
    
}

@property (nonatomic , strong) UIButton *msgBtn;

@property (nonatomic , strong) UIButton *basicBtn;
@property (nonatomic , strong) UIButton *otherBtn;

@property(nonatomic,weak)UIScrollView *sc;


@property (nonatomic ,strong) MineBasicView *mineView;
@property (nonatomic , strong)NSArray *sectionName;
@property (nonatomic , strong)NSArray *contentArr;
@property (nonatomic , strong)WUserInFo *wuser;
@property (strong, nonatomic) NSMutableArray *jyArr;
@property (strong, nonatomic) NSMutableArray *zyArr;
@property (strong, nonatomic) NSMutableArray *zjArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MineViewController
-(NSMutableArray *)jyArr
{
    if (_jyArr == nil) {
        _jyArr = [NSMutableArray array];
    }
    return _jyArr;
}
-(NSMutableArray *)zyArr
{
    if (_zyArr == nil) {
        _zyArr = [NSMutableArray array];
    }
    return _zyArr;
}
-(NSMutableArray *)zjArr
{
    if (_zjArr == nil) {
        _zjArr = [NSMutableArray array];
    }
    return _zjArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.listFriend.userName;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sectionName = @[@"个人简历",@"教育经历",@"职业信息",@"个人专长",@"成长足迹"];
    
    _flag = malloc(sizeof(BOOL)*self.sectionName.count);
    
    memset(_flag, NO, sizeof(BOOL)*self.sectionName.count);

}
-(void)setListFriend:(ListFriend *)listFriend
{
    _listFriend = listFriend;
    
    self.hud = [common createHud];
    [self requestInformation];
    
}
- (void)requestInformation
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_GERENXINXI params:@{@"id":self.listFriend.roadId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                WUserInFo *userinf = [WUserInFo objectWithKeyValues:result[@"obj"]];
                weakSelf.wuser = userinf;
            }
            [self initView];
        }
        [weakSelf.hud hide:YES];
    }];
}
- (void)initView
{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 190)];
    titleView.backgroundColor = GREENCOLOR;
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.mj_w / 2 - 40, 0, 80, 80)];
    //    self.iconImage.bounds = CGRectMake(0, 0, self.iconImage.frame.size.height/2, self.iconImage.frame.size.height/2);
    [iconImage sd_setImageWithURL:[NSURL URLWithString:self.imagUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    iconImage.layer.cornerRadius = iconImage.frame.size.height/2;
    iconImage.clipsToBounds = YES;
    [titleView addSubview:iconImage];
    
    UILabel *passivityLab = [[UILabel alloc]initWithFrame:CGRectMake(20, [iconImage bottom]+10, 55, 25)];
    passivityLab.text =  @"被关注:";
    passivityLab.font = [UIFont systemFontOfSize:14.0];
    passivityLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:passivityLab];
    
    UILabel *passivityConLab = [[UILabel alloc]initWithFrame:CGRectMake(passivityLab.mj_w + passivityLab.mj_x, passivityLab.mj_y, (self.view.mj_w - 195) / 3, 25)];
    passivityConLab.text = [NSString stringWithFormat:@"%d",self.wuser.attentionMeAmount];
    passivityConLab.textColor= [UIColor whiteColor];
    passivityConLab.font = [UIFont systemFontOfSize:14.0];
    passivityConLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:passivityConLab];
    
    UILabel *alreadyLab = [[UILabel alloc]initWithFrame:CGRectMake(passivityConLab.mj_w + passivityConLab.mj_x,passivityLab.mj_y, 55, 25)];
    alreadyLab.text = @"已关注:";
    alreadyLab.font = [UIFont systemFontOfSize:14.0];
    alreadyLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:alreadyLab];
    
    UILabel *alreadyConLab = [[UILabel alloc]initWithFrame:CGRectMake(alreadyLab.mj_w + alreadyLab.mj_x, passivityLab.mj_y, (self.view.mj_w - 195) / 3, 25)];
    alreadyConLab.text =  [NSString stringWithFormat:@"%d",self.wuser.attentionAmount];
    alreadyConLab.textColor = [UIColor whiteColor];
    alreadyConLab.font = [UIFont systemFontOfSize:14.0];
    alreadyConLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:alreadyConLab];
    
    UILabel *commentLab = [[UILabel alloc]initWithFrame:CGRectMake(alreadyConLab.mj_w + alreadyConLab.mj_x,passivityLab.mj_y, 55, 25)];
    commentLab.text = @"回复率:";
    commentLab.font = [UIFont systemFontOfSize:14.0];
    commentLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:commentLab];
    
    UILabel *commentConLab = [[UILabel alloc]initWithFrame:CGRectMake(commentLab.mj_w + commentLab.mj_x, passivityLab.mj_y, (self.view.mj_w - 195) / 3, 25)];
    commentConLab.text =[NSString stringWithFormat:@"%d％",self.wuser.reversionRate];
    commentConLab.textColor = [UIColor whiteColor];
    commentConLab.font = [UIFont systemFontOfSize:14.0];
    commentConLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:commentConLab];

    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame =CGRectMake(DEF_SCREEN_WIDTH/2-130, passivityLab.mj_y + passivityLab.mj_h + 10, 120, Height);
    self.addBtn.backgroundColor = [UIColor blackColor];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.addBtn setImage:[UIImage imageNamed:@"gz"] forState:0];
    [self.addBtn setTitle:self.btnTit forState:0];
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.clipsToBounds = YES;
    self.addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    self.addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [titleView addSubview:self.addBtn];
    
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame =CGRectMake([self.addBtn right]+20, self.addBtn.mj_y, self.addBtn.mj_w, self.addBtn.mj_h);
    msgBtn.backgroundColor = GREENCOLOR;
    msgBtn.layer.borderColor= [UIColor whiteColor].CGColor;
    msgBtn.layer.borderWidth = 1;
    msgBtn.layer.cornerRadius = 5;
    msgBtn.clipsToBounds = YES;
//    msgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [msgBtn setTitleColor:[UIColor whiteColor] forState:0];
    [msgBtn setImage:[UIImage imageNamed:@"sixin"] forState:0];
    [msgBtn setTitle:[NSString stringWithFormat:@"  私信"] forState:0];
    msgBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 75);
    msgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [msgBtn addTarget:self action:@selector(msgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:msgBtn];
    self.msgBtn = msgBtn;

    [sc addSubview:titleView];
    
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];

    
    label1.text = @"基本信息";
    label2.text = @"其他信息";

    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;

    self.mineView = [MineBasicView new];
    self.mineView.nameConLab.text = self.wuser.trueName;
    if (self.wuser.gender==0) {
        self.mineView.sexConLab.text = @"女";
    }else
    {
        self.mineView.sexConLab.text = @"男";
    }
    NSString *dat =[common sectionStrByCreateTime:self.wuser.birthday];
    NSArray *daArr = [dat componentsSeparatedByString:@" "];
    self.mineView.dateConLab.text = [daArr objectAtIndex:0];
    self.mineView.workConLab.text = self.wuser.industryName;
//    self.mineView.linkmanConLab.text = self.wuser.telephone;
    self.mineView.phoneConLab.text = self.wuser.phoneNumber;
    self.mineView.emailConLab.text = self.wuser.email;
    self.mineView.QQConLab.text = self.wuser.qq;
    
    UIView *mine = [UIView new];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableview.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mine addSubview:tableview];

    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, titleView.mj_h + titleView.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height - titleView.mj_h - titleView.mj_y) itemArray:@[label1,label2] contentArray:@[self.mineView,mine]];
//    self.wjScroll.delegate = self;
    [sc addSubview:self.wjScroll];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
    
    sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + 50);
    [self.view addSubview:sc];
    self.sc = sc;
}
/**
 * 加关注
 */
- (void)addBtnClick:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"取消关注"])
    {
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,self.wuser.infoId];
        WEAKSELF;
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    [weakSelf.addBtn setTitle:@"关注  " forState:0];
                }else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];

    }else
    {
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,self.wuser.infoId];
        WEAKSELF;
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [weakSelf.addBtn setTitle:@"取消关注" forState:0];
                }else
                {
//                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
}
/**
 * 私信 msgBtnClick
 */
- (void)msgBtnClick
{
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.userInfoId =self.wuser.infoId;
    [self.navigationController pushViewController:newsVC animated:YES];
}
- (void)basicBtnAction
{
    
}
- (void)otherBtnAction
{
    
}
- (UIButton *)createBtnWithFrame:(CGRect)frame wihtAction:(SEL)action andTarget:(id)target
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (UIView *)createViewWithFrame:(CGRect)frame withIcon:(NSString *)icon withTitle:(NSString *)title
{
    UIView *views = [[UIView alloc] initWithFrame:frame];
    views.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ImgH, ImgH)];
    icone.image = [UIImage imageNamed:icon];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(icone.mj_x + icone.mj_w, 5,  100, 20)];
    lblText.text = title;
    lblText.font = [UIFont systemFontOfSize:16.0f];
    lblText.textColor = [UIColor blackColor];
    [views addSubview:icone];
    [views addSubview:lblText];
    return views;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_flag[section] == YES) {
        return 1;
    }else{
        return 0;
    }
}
//自定义sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //headerFooterView也可以重用，重用思想和cell一样。
    UITableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!head) {
        head = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    }
    head.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *view in [head subviews]) {
            [view removeFromSuperview];
        }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:[self.sectionName objectAtIndex:section] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 40);
    button.backgroundColor = [UIColor whiteColor];
//    button.tag = section;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, button.mj_w-100);
    [head addSubview:button];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-50, button.mj_h/3, button.mj_h/3+5, button.mj_h/3-5)];
    image.tag = section;
    image.image = [UIImage imageNamed:@"down"];
    [head addSubview:image];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.frame = CGRectMake(20, [button bottom]-2, DEF_SCREEN_WIDTH-40, 0.5);
    [head addSubview:lineView];
    
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)headerButtonClick:(UIButton *)sender{
    NSInteger index = [self.sectionName indexOfObject:sender.currentTitle];
    _flag[index] = !_flag[index];
    //动画重载某个区
    [tableview reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
//    UIImageView *img = (UIImageView *)[sender.superview viewWithTag:index];
//    if (_flag[index] == YES)
//    {
//        img.transform=CGAffineTransformMakeRotation(M_PI);
//    }else
//    {
//        img.transform=CGAffineTransformMakeRotation(M_PI);
//    }
    switch (index)
    {
        case 0:
        {
        }
            break;
        case 1:
        {
            if (self.jyArr.count==0)
            {
                WEAKSELF;
                [[HttpManager defaultManager] postRequestToUrl:DEF_ZYJIAOYUJL params:@{@"createBy":self.wuser.infoId} complete:^(BOOL successed, NSDictionary *result) {
                    if (successed) {
//                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        if ([result[@"code"] isEqualToString:@"10000"]) {
                            Education *jiaoyu = [Education objectWithKeyValues:result[@"lists"]];
                            [weakSelf.jyArr addObjectsFromArray:jiaoyu.content];
                            [tableview reloadData];
                        }
                    }
                }];
            }
        }
            break;
        case 2:
        {
            if (self.zyArr.count==0)
            {
                WEAKSELF;
//                DEF_USERID // 用户id
                [[HttpManager defaultManager] postRequestToUrl:DEF_ZYZHIYEXX params:@{@"createBy":self.wuser.infoId} complete:^(BOOL successed, NSDictionary *result) {
                    if (successed) {
//                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        if ([result[@"code"] isEqualToString:@"10000"]) {
                            Education *zhiye = [Education objectWithKeyValues:result[@"lists"]];
                            [weakSelf.zyArr addObjectsFromArray:zhiye.content];
                            [tableview reloadData];
                        }
                    }
                }];
            }
        }
            break;
        case 3:
        {
        }
            break;
        case 4:
        {
            if (self.zjArr.count==0) {
                WEAKSELF;
                [[HttpManager defaultManager] postRequestToUrl:DEF_ZYCHENGZHANGZJ params:@{@"createBy":self.wuser.infoId} complete:^(BOOL successed, NSDictionary *result) {
                    if (successed) {
//                        [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                        if ([result[@"code"] isEqualToString:@"10000"]) {
                            Education *zuji = [Education objectWithKeyValues:result[@"lists"]];
                            [weakSelf.zjArr addObjectsFromArray:zuji.content];
                            [tableview reloadData];
                        }
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.section==0)
    {
        cell.textLabel.text = self.wuser.individualResume? self.wuser.individualResume:@"无";
    }else if (indexPath.section ==1)
    {
        NSMutableString *result = [NSMutableString string];
        for (EducationCont *zy in self.jyArr)
        {
            [result appendFormat:@"%d  %@  %@",zy.schoolType,zy.schoolName,zy.academyName];
        }
        cell.textLabel.text =result?result:@"无";
    }else if (indexPath.section ==2)
    {
        NSMutableString *result = [NSMutableString string];
        for (EducationCont *zy in self.zyArr)
        {
            NSString *stareDate = [common sectionStrByCreateTime:zy.workStartDate];
            NSString *endDate = [common sectionStrByCreateTime:zy.workEndDate];
            [result appendFormat:@"%@  %@  %@  %@",zy.organizationName,stareDate,endDate,zy.position];
        }
        cell.textLabel.text =result?result:@"无";
    }else if (indexPath.section ==3)
    {
        cell.textLabel.text =self.wuser.speciality? self.wuser.speciality:@"无";
    }else if (indexPath.section ==4)
    {
        NSMutableString *result = [NSMutableString string];
        for (EducationCont *zj in self.zjArr)
        {
            [result appendFormat:@"%@  %@",zj.footprintTime,zj.incident];
        }
        cell.textLabel.text =result?result:@"无";
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionName.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *str = self.contentArr[indexPath.section];
//    UITableViewCell *cel = [tableView cellForRowAtIndexPath:indexPath];
//    CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40, cell.textLabel.text, 14);
    switch (indexPath.section)
    {
        case 0:
        {
           CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH,self.wuser.individualResume, 14);
            NSLog(@"***^^^%f",size.height);
            return size.height+20;
        }
            break;
        case 1:
        {
            CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40,self.wuser.speciality, 14);
            return size.height+20;

        }
            break;
        case 2:
        {
            NSMutableString *result = [NSMutableString string];
            for (EducationCont *zy in self.zyArr)
            {
                NSString *stareDate = [common sectionStrByCreateTime:zy.workEndDate];
                NSString *endDate = [common sectionStrByCreateTime:zy.workEndDate];
                [result appendFormat:@"%@  %@  %@  %@",zy.organizationName,stareDate,endDate,zy.position];
            }
            CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40,result, 14);
            return size.height+30;
        }
            break;
        case 3:
        {
            CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40,self.wuser.speciality, 14);
            return size.height+20;
        }
            break;
        case 4:
        {
            NSMutableString *result = [NSMutableString string];
            for (EducationCont *zj in self.zyArr)
            {
                [result appendFormat:@"%@  %@",zj.footprintTime,zj.incident];
            }
            CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40,result, 14);
            return size.height+20;

        }
            break;
        default:
            break;
    }
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
