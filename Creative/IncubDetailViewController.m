//
//  IncubDetailViewController.m
//  Creative
//
//  Created by huahongbo on 16/3/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "IncubDetailViewController.h"
#import "Qualification.h"
@interface IncubDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
    NSArray *oneArr;
    NSArray *twoArr;
    NSArray *oneContArr;
    NSArray *twoContArr;
}
@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation IncubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"基础信息";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.hud = [common createHud];
//    [self loadDetailData];
    oneArr =@[@"企业名称",@"区域",@"成立时间",@"类型"];
    twoArr =@[@"单位官网",@"单位地址",@"传真",@"邮政编码",@"微信公众号"];
    myTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableVIew.delegate = self;
    myTableVIew.dataSource = self;
    myTableVIew.backgroundColor = GRAYCOLOR;
    //    myTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableVIew];
    [self addHeadView];
    
    oneContArr = @[[common checkStrValue:self.incubx.companyName],[common checkStrValue:self.incubx.cityName],[common sectionStrByCreateTime:self.incubx.settledDate],[common checkStrValue:self.incubx.industry]];
    twoContArr =@[[common checkStrValue:self.incubx.companyWebsite],[common checkStrValue:self.incubx.address],[common checkStrValue:self.incubx.fax],[common checkStrValue:self.incubx.postcode],[common checkStrValue:self.incubx.postcode]];
    [myTableVIew reloadData];
}
- (void)addHeadView
{
    UIView *aView = [[UIView alloc] init];
    aView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT/5);
    aView.backgroundColor = GREENCOLOR;
    [self.view addSubview:aView];
    UIImageView *img= [[UIImageView alloc] init];
    img.frame = CGRectMake(DEF_SCREEN_WIDTH/4, 10, DEF_SCREEN_WIDTH/2, aView.mj_h-30);
    [img sd_setImageWithURL:[NSURL URLWithString:self.incubat.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    [aView addSubview:img];
    
    myTableVIew.tableHeaderView = aView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return oneArr.count;
    }else if (section==1)
    {
        return twoArr.count;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.detailTextLabel.text = @"";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.font =[UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0)
    {
        cell.textLabel.text = oneArr[indexPath.row];
        cell.detailTextLabel.text = oneContArr[indexPath.row];
        
    }else if (indexPath.section==1)
    {
        cell.textLabel.text = twoArr[indexPath.row];
        cell.detailTextLabel.text = twoContArr[indexPath.row];
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            cell.textLabel.text = @"简介";
        }else
        {
            cell.textLabel.text =[common checkStrValue:self.incubx.individualResume];
        }
    }else if (indexPath.section==3)
    {
        if (indexPath.row==0) {
            cell.textLabel.text = @"孵化器资质";
        }else
        {
//            cell.textLabel.text = [common checkStrValue:self.incubx.qualificationList];
            NSMutableString *result = [NSMutableString string];
            for (Qualification *qualif in self.incubx.qualificationList)
            {
                [result appendFormat:@"%@",qualif.qualifications];
            }
            cell.textLabel.text =result?result:@"无";
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        if (indexPath.row==1)
        {
            CGSize hei = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.incubx.individualResume, 14)
            return hei.height+50;
        }
    }else if (indexPath.section ==3)
    {
        if (indexPath.row==1) {
            NSMutableString *result = [NSMutableString string];
            for (Qualification *qualif in self.incubx.qualificationList)
            {
                [result appendFormat:@"%@\n",qualif.qualifications];
            }
            CGSize heig =STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, result, 14)
            return heig.height+20;
        }
    }
    return 44;
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
