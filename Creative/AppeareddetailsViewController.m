//
//  AppeareddetailsViewController.m
//  Creative
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "AppeareddetailsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+MJExtension.h"
#import "common.h"
#import "NewsViewController.h"
#import "Object.h"
#import "SupportViewController.h"
#import "CommentsTableViewCell.h"
#import "Object.h"
#import "Result.h"
#import "NSDate+Utilities.h"
#import "LoadingSiteViewController.h"
#import "AchievementViewController.h"
#import "SqTableViewController.h"

@interface AppeareddetailsViewController ()<UITableViewDataSource,UITableViewDelegate,WJSliderViewDelegate,UITextFieldDelegate>
{
    UITableView *comTableView;
    NSMutableArray *comDateModelArr;
    NSMutableArray *noteDateArr;
    int selectNum;
    int relation;
    CGSize size1 ;
    CGSize size4 ;
    CGSize size6 ;
    CGSize size7 ;
    
}
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (nonatomic , strong) UIView *titleView; // 头部
@property (nonatomic , strong) UIImageView *iconImage; // 头像
@property (nonatomic , strong) UIView *line; // 灰线
@property (nonatomic , strong) UILabel *nameLab; // 发起人
@property (nonatomic , strong) UILabel *nameText; // 发起人姓名
@property (nonatomic , strong) UIButton *addBtn; // 添加关注
@property (nonatomic , strong) UILabel *focusLab; // 关注
@property (nonatomic , strong) UIButton *msgBtn;// 发私信
@property (nonatomic , strong) UILabel *msgLab;

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *lblCon;
@property(nonatomic,weak)UILabel *lblDate;
@property(nonatomic,weak)UILabel *lblDat;
@property(nonatomic,weak)UIImageView *im;

@property (nonatomic , strong) UIImageView *placeImage;
@property (nonatomic , strong) UILabel *placeLab;

@property(nonatomic,assign)BOOL isHide;
@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,weak)UIImageView *imClock;


@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,copy)NSString *strd;
@property (nonatomic , strong) UIButton *praiseBtn; //点赞
@property (nonatomic , strong) UILabel *praiseLab; // 点赞数

@property (nonatomic , strong) UILabel *introLab;
@property (nonatomic , strong) UIView *lineintro;
@property (nonatomic , strong) UILabel *requestLab;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIButton *btn;
@property (nonatomic , strong) UILabel *annexLab;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UILabel *annexConLab;
@property (nonatomic , strong) UILabel *personLab;
@property (nonatomic , strong) UILabel *personConLab;
@property (nonatomic , strong) UILabel *mobileLab;
@property (nonatomic , strong) UILabel *mobileConLab;
@property (nonatomic , strong) UILabel *cellphoneLab;
@property (nonatomic , strong) UILabel *cellphConLab;
@property (nonatomic , strong) UILabel *emailLab;
@property (nonatomic , strong) UILabel *emailConLab;
@property (nonatomic , strong) UILabel *qqLab;
@property (nonatomic , strong) UILabel *qqConLab;

@property (nonatomic , strong) UIView *commentView;
@property (nonatomic , strong) UITextField *commentText;
@property (nonatomic , strong) UIButton *sendBtn;

@property (nonatomic , strong) UIView *sectionView;
@property (nonatomic , strong) UILabel *commentNum;
@property (nonatomic , strong) UIButton *prasBtn;
@property (nonatomic , strong) UILabel *prasNum;
@property (nonatomic , strong) UIButton *comSendBtn;
@property (nonatomic , strong) UILabel *comSendNum;

@property (nonatomic , strong) UILabel *competeLab;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UILabel *competeConLab;
@property (nonatomic , strong) UILabel *pointLab;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UILabel *pointConLab;
@property (nonatomic , strong) UILabel *declarerLab;
@property (nonatomic , strong) UIView *line6;
@property (nonatomic , strong) UILabel *declarerConLab;
@property (nonatomic , strong) UILabel *panterLab;
@property (nonatomic , strong) UIView *line7;
@property (nonatomic , strong) UILabel *panterConLab;
@property (nonatomic , strong) UILabel *endLab;

@property (nonatomic , strong) UIButton *publicBtn;
@property (nonatomic , strong) UIButton *praiteBtn;
@property (nonatomic , copy) NSString *publicityType;

@property (nonatomic,strong)Object *objec;
@property (nonatomic , strong) Result *results;
@property(nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic , strong) NSArray *stageArr;
@property (nonatomic , strong) NSArray *panterArr;

@property (nonatomic , strong) UIImageView *arrowImage;
@property (nonatomic , strong) UIButton *titleBtn;

@end

@implementation AppeareddetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor=[UIColor grayColor];
    self.title=self.listF.name;
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.hud = [common createHud];
    self.currentPage = 1;
    _cellNumArr = [NSMutableArray array];
    [self loadRequestDetailView];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadRequestDetailView
{
//    // 1.设置请求路径
//         NSURL *URL=[NSURL URLWithString:@"http://192.168.1.53:8080/MJServer/login"];//不需要传递参数
//    
//     //    2.创建请求对象
//         NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
//         request.timeoutInterval=5.0;//设置请求超时为5秒
//         request.HTTPMethod=@"POST";//设置请求方法
//    
//         //设置请求体
//       NSString *param=[NSString stringWithFormat:@"username=%@&pwd=%@",self.username.text,self.pwd.text];
//       //把拼接后的字符串转换为data，设置请求体
//    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTDETAIL params:@{@"id":self.listF.roadId,@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Object *obj = [Object objectWithKeyValues:result[@"obj"]];
                weakSelf.objec = obj;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
                dispatch_async(queue, ^{
                                       [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUDIANZAN params:@{@"businessId":self.listF.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
                        if (successed)
                        {
                            NSString *praise = result[@"obj"][@"isPraise"];
                            selectNum = [praise intValue];
                            if ([praise isEqualToString:@"1"]) {
                                [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
                            }else
                            {
                                [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
                            }
                        }
                    }];
                });
            
                [self headerRefreshing];
                [self initView];
                [self initData];
                MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
                comTableView.header = refreshHeader;
                
                MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
                comTableView.footer = refreshFooter;
                
                static NSDateFormatter *formatter = nil;
                if (nil == formatter) {
                    formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                }
                NSDate *dat = [NSDate dateWithTimeIntervalSince1970:(self.objec.bidLimitDate / 1000)];
                if ([dat isEarlierThanDate:[NSDate date]]==YES)
                {
                    //                self.endLab.hidden = NO;
                    //                self.signUpBtn.hidden = YES;
                }else
                {
                    //                self.endLab.hidden = YES;
                    //                self.signUpBtn.hidden = NO;
                }
                
                //            [self searchMesage];
            }
        }
        [weakSelf.hud hide:YES];
    }];
    
    
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [comTableView.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listF.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [comTableView.header endRefreshing];
                Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
                weakSelf.results = resul;
                self.comSendNum.text = resul.totalElements;
                weakSelf.totalPage = resul.totalPages;
                [_cellNumArr removeAllObjects];
                [_cellNumArr addObjectsFromArray:resul.content];
                [comTableView reloadData];
            }
        }
    }];
}
//上拉加载
- (void)footerRereshing
{
    _currentPage ++;
    if (self.currentPage > self.totalPage) {
        _currentPage --;
        [comTableView.footer noticeNoMoreData];
        return;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listF.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [comTableView.header endRefreshing];
                Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
                weakSelf.results = resul;
                weakSelf.totalPage = resul.totalPages;
                [_cellNumArr addObjectsFromArray:resul.content];
                [comTableView reloadData];
                [comTableView.footer endRefreshing];
            }
        }
        [comTableView.footer endRefreshing];
    }];
}
- (void)initData
{
 
    
    UIView *grayView0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 5)];
    grayView0.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.sc addSubview:grayView0];
    
    
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0,  grayView0.mj_h + grayView0.mj_y, self.view.mj_w, 1)];
    line0.backgroundColor = [UIColor lightGrayColor];
    [self.sc addSubview:line0];
    
    self.titleView.frame = CGRectMake(0, grayView0.mj_h + grayView0.mj_y + 1, self.view.mj_w, 60);
    self.titleBtn.frame = CGRectMake(0, 0, self.view.mj_w, 60);
    self.iconImage.frame = CGRectMake(10, 10, 40, 40);
    //    iconImage.bounds = CGRectMake(0, 0, iconImage.frame.size.height/2, iconImage.frame.size.height/2);
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.height/2;
    self.iconImage.clipsToBounds = YES;
    
    self.line.frame = CGRectMake(0, self.titleView.mj_h + self.titleView.mj_y, self.view.mj_w , 0.5);
    self.nameLab.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 5, self.iconImage.mj_y + 5, 60, 30);
    self.nameText.frame = CGRectMake(self.nameLab.mj_w + self.nameLab.mj_x, self.nameLab.mj_y, self.view.mj_w  - self.nameLab.mj_w - self.nameLab.mj_x - 50, self.nameLab.mj_h);
    
    self.arrowImage.frame = CGRectMake(self.nameText.mj_w + self.nameText.mj_x + 5, self.nameText.mj_y+5, 10, 20);
       UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleView.mj_h + self.titleView.mj_y + 2, self.view.mj_w, 5)];
    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];;
    [self.sc addSubview:grayView1];
    
    self.titleLab.frame = CGRectMake(10, self.titleView.mj_y + self.titleView.mj_h + 10, self.view.mj_w -20, 30);
    
    
    self.imClock .frame = CGRectMake(10,  self.titleLab.mj_h + self.titleLab.mj_y + 18, 15, 15);
    
    self.lblDat.frame = CGRectMake(self.imClock.mj_w + self.imClock.mj_x ,self.titleLab.mj_h + self.titleLab.mj_y + 16, 70, 20);
    self.lblDate.frame = CGRectMake(self.lblDat.mj_w + self.lblDat.mj_x ,self.titleLab.mj_y+ self.titleLab.mj_h + 15, 90, 20);
    
    self.placeImage.frame = CGRectMake(self.lblDate.mj_x + self.lblDate.mj_w + 2, self.imClock.mj_y, 15, 15);
    
    self.placeLab.frame = CGRectMake(self.placeImage.mj_x + self.placeImage.mj_w + 1, self.lblDate.mj_y, self.view.mj_w - self.placeImage.mj_x - self.placeImage.mj_w - 13, self.lblDate.mj_h);
    
    self.im.frame = CGRectMake(10, self.lblDat.mj_y + self.lblDat.mj_h + 20, self.view.mj_w - 20, (self.view.mj_w - 20)/5*3);
    
    self.praiseBtn.frame = CGRectMake(10, self.im.mj_y + self.im.mj_h + 20, 25 , 25);
    self.praiseLab.frame = CGRectMake(self.praiseBtn.mj_w + self.praiseBtn.mj_x , self.im.mj_y + self.im.mj_h + 20, self.view.mj_w / 2 , 25);
    
    
    
}
- (void)initView
{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h-64)];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    UIView *titleView = [[UIView alloc]init];
    titleView.userInteractionEnabled = YES;
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:self.objec.userInfo.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    [titleView addSubview:iconImage];
    iconImage.userInteractionEnabled = YES;
    self.iconImage = iconImage;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [sc addSubview:line];
    self.line = line;
    
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = @"发起人:";
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.userInteractionEnabled = YES;
    self.nameLab = nameLab;
    
    UILabel *nameText = [[UILabel alloc]init];
    nameText.textColor = [UIColor lightGrayColor];
    nameText.text = self.objec.userInfo.loginName;
    nameText.userInteractionEnabled = YES;
    [titleView addSubview:nameText];
    [titleView addSubview:nameLab];
    self.nameText = nameText;
    
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    [titleView addSubview:arrowImage];
    arrowImage.image = [UIImage imageNamed:@"arrow"];
    arrowImage.userInteractionEnabled = YES;
    self.arrowImage = arrowImage;
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn addTarget:self action:@selector(titleViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [titleView addSubview:titleBtn];
    
    self.titleBtn = titleBtn;
    
    [sc addSubview:titleView];
    self.titleView = titleView;
    
    UILabel *titleLab = [common createLabelWithFrame:CGRectZero andText:self.strTitle];
    titleLab.numberOfLines = 0;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.objec.name;
    [sc addSubview:titleLab];
    self.titleLab = titleLab;
    //
    UIImageView *imclock = [[UIImageView alloc] init];
    imclock.image = [UIImage imageNamed:@"clock"];
    [sc addSubview:imclock];
    self.imClock = imclock;
    
    UILabel *lblDat = [common createLabelWithFrame:CGRectZero andText:self.strd];
    
    lblDat.font = [UIFont systemFontOfSize:14.0f];
    lblDat.text = @"更新时间:";
    [sc addSubview:lblDat];
    self.lblDat = lblDat;
    
    
    UILabel *lblDate = [common createLabelWithFrame:CGRectZero andText:self.strd];
    
    lblDate.font = [UIFont systemFontOfSize:14.0f];
    lblDate.text = [common sectionStrByCreateTime:self.objec.createDate];
    [sc addSubview:lblDate];
    self.lblDate = lblDate;
    
    
    UIImageView *placeImage = [[UIImageView alloc] init];
    placeImage.image = [UIImage imageNamed:@"needle"];
    placeImage.layer.masksToBounds = YES;
    [sc addSubview:placeImage];
    self.placeImage  = placeImage;
    
    UILabel *placeLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
    placeLab.text = [NSString stringWithFormat:@"%@   %@",[common checkStrValue:self.objec.provinceName],[common checkStrValue:self.objec.cityName]];
    placeLab.font = [UIFont systemFontOfSize:14.0f];
    [sc addSubview:placeLab];
    self.placeLab = placeLab;
    
    
    UIImageView *im = [[UIImageView alloc] init];
    im.layer.masksToBounds = YES;
    [im sd_setImageWithURL:[NSURL URLWithString:self.objec.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    [sc addSubview:im];
    self.im = im;
    im.hidden = self.isHide;
    
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [praiseBtn addTarget:self action:@selector(praiseBtnActi:) forControlEvents:UIControlEventTouchUpInside];
    praiseBtn.layer.masksToBounds = YES;
    praiseBtn.layer.cornerRadius = 4;
    self.praiseBtn = praiseBtn;
    [sc addSubview:praiseBtn];
    
    UILabel *praiseLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
    praiseLab.font = [UIFont systemFontOfSize:14.0f];
    [sc addSubview:praiseLab];
    praiseLab.text = [NSString stringWithFormat:@"%d",self.objec.praiseCount];
    self.praiseLab = praiseLab;
    
    self.sc = sc;
    [self.view addSubview:sc];
    
}

- (void)praiseBtnActi:(UIButton *)sender
{
    if (selectNum%2==1) {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_DIANZAN params:@{@"businessId":self.listF.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"点赞成功" toView:weakSelf.view];
                    weakSelf.praiseLab.text = [NSString stringWithFormat:@"%d",[weakSelf.praiseLab.text intValue]+1];
                }
            }
        }];
    }else
    {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_QUXIAODIANZAN params:@{@"businessId":self.listF.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"已取消点赞" toView:weakSelf.view];
                    weakSelf.praiseLab.text = [NSString stringWithFormat:@"%d",[weakSelf.praiseLab.text intValue]-1];
                }
            }
        }];
    }
    selectNum ++;
    
}

- (void)titleViewAction:(UIButton *)sender
{
   
}

#pragma mark - tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return comDateModelArr.count;
    return _cellNumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
    
    ListFriend *listobjc = [_cellNumArr objectAtIndex:indexPath.row];
    
    if ([listobjc.vo isKindOfClass:[NSDictionary class]])
    {
        cell.nameLab.text = [listobjc.vo objectForKey:@"loginName"];
        if ([listobjc.vo objectForKey:@"image"]) {
            NSString *imUrl = [[listobjc.vo objectForKey:@"image"] objectForKey:@"absoluteImagePath"];
            [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:imUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
        }
        
    }
    
    cell.dateLab.text =[common compareCurrentTime:listobjc.createDate];
    cell.contLab.text = listobjc.content;
    //    Object *objc = [comDateModelArr objectAtIndex:indexPath.row];
    //    cell.nameLab.text = objc.loginName;
    //    cell.dateLab.text = objc.createDatecom;
    //    cell.contLab.text = objc.content;
    //    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:objc.imageUrl] placeholderImage:nil];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
