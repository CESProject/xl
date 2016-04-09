//
//  BusinessCardViewController.m
//  Creative
//
//  Created by huahongbo on 16/1/29.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "BusinessCardViewController.h"
#import "Business.h"
#import "common.h"
@interface BusinessCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Business *busi;
    NSArray *titlArr;
    NSArray *contArr;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BusinessCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的名片";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    titlArr = @[@"性别",@"从事行业",@"电话"];
    // 加载数据
    [self loadDatas];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DEF_SCREEN_WIDTH/3+40, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;


    
}
- (void)loadDatas
{
    WEAKSELF;
    NSLog(@"=====>%@",DEF_USERID);
    [[HttpManager defaultManager] postRequestToUrl:DEF_GERENMINGXINPIAN params:@{@"userId":DEF_USERID} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([result[@"code"] isEqualToString:@"10000"]) {
                Business *bus = [Business objectWithKeyValues:result[@"obj"]];
                busi = bus;
                [weakSelf.tableView reloadData];
                // 加载头部视图
                [self addHeadView];
                [self addFooterView];
                if ([bus.gender isEqualToString:@"1"]) {
                    bus.gender =@"女";
                }else if ([bus.gender isEqualToString:@"0"])
                {
                    bus.gender = @"男";
                }else
                {
                    bus.gender = @"";
                }
                contArr = @[bus.gender?bus.gender:@"",bus.industry?bus.industry:@"",bus.phoneNumber?bus.phoneNumber:@""];
            }
        }
    }];

}
#pragma mark - 添加表的头部和尾部视图
/**
 *   头部视图
 */
- (void)addHeadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0,64, DEF_SCREEN_WIDTH, DEF_SCREEN_WIDTH/3+40);
    [self.view addSubview:view];
    
    //头像
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, DEF_SCREEN_WIDTH/3, DEF_SCREEN_WIDTH/3)];
    [img sd_setImageWithURL:[NSURL URLWithString:busi.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    [view addSubview:img];
    
    UILabel *nameLab = [[UILabel alloc] init];
    CGSize size1 ;
    if (!busi.loginName || [busi.loginName isEqualToString:@""]) {
        nameLab.frame = CGRectMake([img right]+20, img.mj_y, 50, 20);
        
    }
    else
    {
        size1 = STRING_SIZE_FONT_WIDTH(20, busi.loginName, 14.0);
        if (size1.height < 30) {
            size1.height = 30;
        }
        nameLab.frame = CGRectMake(img.mj_x + img.mj_w + 20, img.mj_y, size1.width + 10, 20);
        
    }
    
    nameLab.text = busi.loginName;
    [view addSubview:nameLab];
    
    UILabel *zyLab = [[UILabel alloc] initWithFrame:CGRectMake([nameLab right]+10, nameLab.mj_y, 50, nameLab.mj_h)];
    zyLab.backgroundColor = DEF_RGB_COLOR(235, 234, 234);
    zyLab.text = busi.personType;
    zyLab.textColor = [UIColor blueColor];
    [view addSubview:zyLab];
    
    UILabel *bgzLab =[[UILabel alloc] initWithFrame:CGRectMake(nameLab.mj_x, [nameLab bottom]+10, 200, zyLab.mj_h)];
    bgzLab.textColor = [UIColor lightGrayColor];
    bgzLab.text = [NSString stringWithFormat:@"被关注 : %@",[common checkStrValue:busi.attentionMeAmount]];
    [view addSubview:bgzLab];
    
    UILabel *gzLab=[[UILabel alloc] initWithFrame:CGRectMake(nameLab.mj_x, [bgzLab bottom]+10, 200, zyLab.mj_h)];
    gzLab.textColor = [UIColor lightGrayColor];
    gzLab.text = [NSString stringWithFormat:@"已关注 : %@",[common checkStrValue:busi.attentionAmount]];
    [view addSubview:gzLab];
    
    UILabel *pjLab=[[UILabel alloc] initWithFrame:CGRectMake(nameLab.mj_x, [gzLab bottom]+10, 200, zyLab.mj_h)];
    pjLab.textColor = [UIColor lightGrayColor];
    pjLab.text = [NSString stringWithFormat:@"评价 : %@",[common checkStrValue:busi.reversionRate]];
    [view addSubview:pjLab];
}
/**
 *   添加尾部视图
 */
- (void)addFooterView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, DEF_SCREEN_WIDTH, 100)];
    footView.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    lab.text = @"个人专长";
    lab.textColor = [UIColor lightGrayColor];
    [footView addSubview:lab];
    
    CGSize size=STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, busi.speciality, 15);
    UILabel *spe = [[UILabel alloc] initWithFrame:CGRectMake(lab.mj_x, [lab bottom]+5, footView.mj_w-lab.mj_x*2,size.height+10)];
    spe.text = busi.speciality;
    [footView addSubview:spe];
    
    self.tableView.tableFooterView = footView;
    
}
#pragma mark - tableView的Delegate和DataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // 解决重用
    [cell.contentView removeAllSubviews];
    cell.textLabel.text = titlArr[indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = contArr[indexPath.row];
    return cell;
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
