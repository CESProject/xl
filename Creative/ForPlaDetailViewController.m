//
//  ForPlaDetailViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ForPlaDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "PriceViewController.h"
#import "AchievementViewController.h"

@interface ForPlaDetailViewController ()

@property (nonatomic , strong)  UIView *titleView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *postBtn;

@property(nonatomic,weak) UIScrollView *sc;
@property (nonatomic , strong) UIView *Imsection;
@property (nonatomic , strong) UIImageView *Imview;

/////////////////////////////////

@property (nonatomic , strong) UILabel *placeLab;
@property (nonatomic , strong) UILabel *placeConLab;

@property (nonatomic , strong) UILabel *siteLab;
@property (nonatomic , strong) UILabel *siteConLab;
@property (nonatomic , strong) UILabel *acreageLab;
@property (nonatomic , strong) UILabel *acreageConLab;
@property (nonatomic , strong) UILabel *perNUmLab;
@property (nonatomic , strong) UILabel *perNumConLab;

@property (nonatomic , strong) UILabel *areaNumLab;
@property (nonatomic , strong) UILabel *areaNumConLab;
@property (nonatomic , strong) UILabel *pliesNum;
@property (nonatomic , strong) UILabel *pliesConNum;
@property (nonatomic , strong) UILabel *guestLab;
@property (nonatomic , strong) UILabel *guestConLab;

@property (nonatomic , strong) UILabel *guestPriceLab;
@property (nonatomic , strong) UILabel *guestPriceConLab;

@property (nonatomic , strong) UILabel *facilityLab;
@property (nonatomic , strong) UILabel *facilityConLab;
@property (nonatomic , strong) UILabel *partyLab;
@property (nonatomic , strong) UILabel *partyConLab;
@property (nonatomic , strong) UILabel *hotelLab;
@property (nonatomic , strong) UILabel *hotelConLab;
@property (nonatomic , strong) UILabel *serveLab;
@property (nonatomic , strong) UILabel *serveConLab;
@property (nonatomic , strong) UILabel *beforeLab;
@property (nonatomic , strong) UILabel *beforeConLab;

@end

@implementation ForPlaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找场地";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self initView];
    //    [self loadServerData];
    
}

- (void)loadServerData
{
//    WEAKSELF;
    [[HttpManager defaultManager]postRequestToUrl:DEF_ZHAOPLACEDETAIL params:@{@"id":self.listFri.roadId} complete:^(BOOL successed, NSDictionary *result) {
        //
        NSLog(@"%@",result);
    }];
}

- (void)initView
{
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.mj_w - 120, 30)];
    titleLab.text = [common checkStrValue:self.listFri.name];
    titleLab.textColor = GREENCOLOR;
    titleLab.font = [UIFont systemFontOfSize:15.0];
    //    titleLab.textAlignment = NSTextAlignmentRight;
    self.titleLab = titleLab;
    [titleView addSubview:titleLab];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [postBtn setFrame:CGRectMake(titleLab.mj_w + titleLab.mj_x + 10, titleLab.mj_y, 80, 30)];
    [postBtn setTitle:@"立即询价" forState:UIControlStateNormal];
    postBtn.layer.masksToBounds = YES;
    postBtn.layer.cornerRadius = 4;
    postBtn.layer.borderWidth = 1;
    postBtn.tintColor = GREENCOLOR;
    postBtn.layer.borderColor = GREENCOLOR.CGColor;
    postBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [postBtn addTarget:self action:@selector(postBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.postBtn = postBtn;
    [titleView addSubview:postBtn];
    
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleView.mj_h + titleView.mj_y + 10, self.view.mj_w, self.view.mj_h - titleView.mj_h - titleView.mj_y - 10)];
    sc.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    UIView *Imsection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_w / 5 * 3)];
    UIImageView *Imview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, self.view.mj_w - 20, (self.view.mj_w - 20) / 5 *3)];
    
    //    Imview.backgroundColor = [UIColor grayColor];
    //    Imsection.backgroundColor = [UIColor orangeColor];
    [Imview sd_setImageWithURL:[NSURL URLWithString:self.listFri.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    self.Imview = Imview;
    [Imsection addSubview:Imview];
    
    
    self.Imsection = Imsection;
    [sc addSubview:Imsection];
    
    
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, Imsection.mj_h + Imsection.mj_y + 10, self.view.mj_w, 190)];
    detailView.backgroundColor = [UIColor whiteColor];
    
    UILabel *placeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 30)];
    placeLab.text = @"地址：";
    placeLab.font = [UIFont systemFontOfSize:14.0];
    placeLab.textColor = COMColor(51, 51, 51, 1.0);
    placeLab.textAlignment = NSTextAlignmentLeft;
    self.placeLab = placeLab;
    
    UILabel *placeConLab = [[UILabel alloc]initWithFrame:CGRectMake(placeLab.frame.size.width +5 , 0, self.view.mj_w - placeLab.frame.size.width -15, 30)];
    placeConLab.font = [UIFont systemFontOfSize:14.0];
    placeConLab.textColor = COMColor(51, 51, 51, 1.0);
    placeConLab.textAlignment = NSTextAlignmentRight;
    placeConLab.text = [common checkStrValue:self.listFri.address];
    self.placeConLab = placeConLab;
    
    [detailView  addSubview:placeLab];
    [detailView  addSubview:placeConLab];
    
    //
    UILabel *siteLab = [[UILabel alloc]initWithFrame:CGRectMake(5, placeConLab.mj_h + placeConLab.mj_y , 120, 30)];
    siteLab.text = @"场地描述：";
    siteLab.font = [UIFont systemFontOfSize:14.0];
    siteLab.textColor = COMColor(51, 51, 51, 1.0);
    siteLab.textAlignment = NSTextAlignmentLeft;
    self.siteLab = siteLab;
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
    butn.frame = CGRectMake(DEF_SCREEN_WIDTH-100, siteLab.mj_y,100, siteLab.mj_h);
    [butn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    butn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [butn setTitle:@"点击查看详情" forState:UIControlStateNormal];
    butn.titleLabel.textAlignment = NSTextAlignmentRight;
    [detailView addSubview:butn];
//    UILabel *siteConLab = [[UILabel alloc]initWithFrame:CGRectMake(siteLab.mj_w+5, placeConLab.mj_h + placeConLab.mj_y, self.view.mj_w - siteLab.frame.size.width -15, 30)];
//    siteConLab.font = [UIFont systemFontOfSize:14.0];
//    siteConLab.textColor = COMColor(51, 51, 51, 1.0);
//    siteConLab.textAlignment = NSTextAlignmentLeft;
//    siteConLab.text = [common checkStrValue:self.listFri.proDescription];
//    self.siteConLab = siteConLab;
    
    [detailView  addSubview:siteLab];
//    [detailView  addSubview:siteConLab];
    
    UILabel *acreageLab = [[UILabel alloc]initWithFrame:CGRectMake(5, siteLab.mj_h + siteLab.mj_y, 120, 30)];
    acreageLab.text = @"会议室最大面积：";
    acreageLab.font = [UIFont systemFontOfSize:14.0];
    acreageLab.textColor = COMColor(51, 51, 51, 1.0);
    acreageLab.textAlignment = NSTextAlignmentLeft;
    self.acreageLab = acreageLab;
    
    UILabel *acreageConLab = [[UILabel alloc]initWithFrame:CGRectMake(acreageLab.mj_w+5,  siteLab.mj_h + siteLab.mj_y, self.view.mj_w - acreageLab.frame.size.width -15, 30)];
    acreageConLab.font = [UIFont systemFontOfSize:14.0];
    acreageConLab.textColor = COMColor(51, 51, 51, 1.0);
    acreageConLab.textAlignment = NSTextAlignmentRight;
    acreageConLab.text = [NSString stringWithFormat:@"%@平方米",[common checkStrValue:self.listFri.maxSize]];
    self.acreageConLab = acreageConLab;
    
    [detailView  addSubview:acreageLab];
    [detailView  addSubview:acreageConLab];
    
    UILabel *perNUmLab = [[UILabel alloc]initWithFrame:CGRectMake(5, acreageConLab.mj_h + acreageConLab.mj_y, 120, 30)];
    perNUmLab.text = @"最多容纳人数：";
    perNUmLab.font = [UIFont systemFontOfSize:14.0];
    perNUmLab.textColor = COMColor(51, 51, 51, 1.0);
    perNUmLab.textAlignment = NSTextAlignmentLeft;
    self.perNUmLab = perNUmLab;
    
    UILabel *perNumConLab = [[UILabel alloc]initWithFrame:CGRectMake(perNUmLab.mj_w+5,  acreageConLab.mj_h + acreageConLab.mj_y, self.view.mj_w - perNUmLab.frame.size.width -15, 30)];
    perNumConLab.font = [UIFont systemFontOfSize:14.0];
    perNumConLab.textColor = COMColor(51, 51, 51, 1.0);
    perNumConLab.textAlignment = NSTextAlignmentRight;
    perNumConLab.text = [NSString stringWithFormat:@"%@人",[common checkStrValue:self.listFri.maxCapacity]];
    self.perNumConLab = perNumConLab;
    
    [detailView  addSubview:perNUmLab];
    [detailView  addSubview:perNumConLab];
    //
    UILabel *areaNumLab = [[UILabel alloc]initWithFrame:CGRectMake(5, perNumConLab.mj_h + perNumConLab.mj_y, 120, 30)];
    areaNumLab.text = @"会议室数量：";
    areaNumLab.font = [UIFont systemFontOfSize:14.0];
    areaNumLab.textColor = COMColor(51, 51, 51, 1.0);
    areaNumLab.textAlignment = NSTextAlignmentLeft;
    self.areaNumLab = areaNumLab;
    
    UILabel *areaNumConLab = [[UILabel alloc]initWithFrame:CGRectMake(areaNumLab.frame.size.width+5, perNumConLab.mj_h + perNumConLab.mj_y, self.view.mj_w - areaNumLab.frame.size.width -15, 30)];
    areaNumConLab.font = [UIFont systemFontOfSize:14.0];
    areaNumConLab.textColor = COMColor(51, 51, 51, 1.0);
    areaNumConLab.textAlignment = NSTextAlignmentRight;
    areaNumConLab.text = [NSString stringWithFormat:@"%@间",[common checkStrValue:self.listFri.meetingRoomNum]];
    self.areaNumConLab = areaNumConLab;
    
    [detailView  addSubview:areaNumLab];
    [detailView  addSubview:areaNumConLab];
    
    
    UILabel *pliesNum = [[UILabel alloc]initWithFrame:CGRectMake(5, areaNumConLab.mj_h + areaNumConLab.mj_y, 120, 30)];
    pliesNum.text = @"会议室最大层高：";
    pliesNum.font = [UIFont systemFontOfSize:14.0];
    pliesNum.textColor = COMColor(51, 51, 51, 1.0);
    pliesNum.textAlignment = NSTextAlignmentLeft;
    self.pliesNum = pliesNum;
    
    UILabel *pliesConNum = [[UILabel alloc]initWithFrame:CGRectMake(pliesNum.mj_w+5, areaNumConLab.mj_h + areaNumConLab.mj_y, self.view.mj_w - pliesNum.frame.size.width -15, 30)];
    pliesConNum.font = [UIFont systemFontOfSize:14.0];
    pliesConNum.textColor = COMColor(51, 51, 51, 1.0);
    pliesConNum.textAlignment = NSTextAlignmentRight;
    pliesConNum.text =  [NSString stringWithFormat:@"%@米",[common checkStrValue:self.listFri.maxLevelLength]];
    self.pliesConNum = pliesConNum;
    
    [detailView  addSubview:pliesNum];
    [detailView  addSubview:pliesConNum];
    
    self.detailView = detailView;
    [sc addSubview:detailView];
    
    
    
    UIView *secondSection = [[UIView alloc]init];
    secondSection.backgroundColor = [UIColor whiteColor];
    
    UILabel *guestLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 30)];
    guestLab.text = @"客房数量：";
    guestLab.font = [UIFont systemFontOfSize:14.0];
    guestLab.textColor = COMColor(51, 51, 51, 1.0);
    guestLab.textAlignment = NSTextAlignmentLeft;
    self.guestLab = guestLab;
    [secondSection  addSubview:guestLab];
    
    UILabel *guestConLab = [[UILabel alloc]initWithFrame:CGRectMake(guestLab.mj_w+5,  0, self.view.mj_w - guestLab.mj_w -15, 30)];
    guestConLab.font = [UIFont systemFontOfSize:14.0];
    guestConLab.textColor = COMColor(51, 51, 51, 1.0);
    guestConLab.textAlignment = NSTextAlignmentRight;
    guestConLab.text = [NSString stringWithFormat:@"%@间",[common checkStrValue:self.listFri.guestRoomNum]];
    self.guestConLab = guestConLab;
    [secondSection  addSubview:guestConLab];
    
    UILabel *guestPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(5, guestConLab.mj_h + guestConLab.mj_y, 120, 30)];
    guestPriceLab.text = @"客房参考价格：";
    guestPriceLab.font = [UIFont systemFontOfSize:14.0];
    guestPriceLab.textColor = COMColor(51, 51, 51, 1.0);
    guestPriceLab.textAlignment = NSTextAlignmentLeft;
    self.guestPriceLab = guestPriceLab;
    
    UILabel *guestPriceConLab = [[UILabel alloc]initWithFrame:CGRectMake(guestPriceLab.mj_w+5, guestConLab.mj_h + guestConLab.mj_y, self.view.mj_w - guestPriceLab.frame.size.width -15, 30)];
    guestPriceConLab.font = [UIFont systemFontOfSize:14.0];
    guestPriceConLab.textColor = COMColor(51, 51, 51, 1.0);
    guestPriceConLab.textAlignment = NSTextAlignmentRight;
    guestPriceConLab.text = [NSString stringWithFormat:@"%@元",[common checkStrValue:self.listFri.guestRoomPrice]];
    self.guestPriceConLab = guestPriceConLab;
    
    [secondSection  addSubview:guestPriceLab];
    [secondSection  addSubview:guestPriceConLab];
    
    UILabel *facilityLab = [[UILabel alloc]initWithFrame:CGRectMake(5, guestPriceConLab.mj_h + guestPriceConLab.mj_y, 120, 30)];
    facilityLab.text = @"场地服务设施：";
    facilityLab.font = [UIFont systemFontOfSize:14.0];
    facilityLab.textColor = COMColor(51, 51, 51, 1.0);
    facilityLab.textAlignment = NSTextAlignmentLeft;
    self.facilityLab = facilityLab;
    
    CGSize facSize =STRING_SIZE_FONT_HEIGHT(self.view.mj_w - facilityLab.frame.size.width -15, [common checkStrValue:self.listFri.serviceFacility], 14)
    
    UILabel *facilityConLab = [[UILabel alloc]initWithFrame:CGRectMake(facilityLab.mj_w+5, guestPriceConLab.mj_h + guestPriceConLab.mj_y, self.view.mj_w - facilityLab.frame.size.width -15, facSize.height+10)];
    facilityConLab.numberOfLines = 0;
    facilityConLab.font = [UIFont systemFontOfSize:14.0];
    facilityConLab.textColor = COMColor(51, 51, 51, 1.0);
    facilityConLab.textAlignment = NSTextAlignmentRight;
    facilityConLab.text = [common checkStrValue:self.listFri.serviceFacility];
    self.facilityConLab = facilityConLab;
    
    [secondSection  addSubview:facilityLab];
    [secondSection  addSubview:facilityConLab];
    
    UILabel *partyLab = [[UILabel alloc]initWithFrame:CGRectMake(5, facilityConLab.mj_h + facilityConLab.mj_y, 120, 30)];
    partyLab.text = @"会议服务设施：";
    partyLab.font = [UIFont systemFontOfSize:14.0];
    partyLab.textColor = COMColor(51, 51, 51, 1.0);
    partyLab.textAlignment = NSTextAlignmentLeft;
    self.partyLab = partyLab;
    
    CGSize parSize =STRING_SIZE_FONT_HEIGHT(self.view.mj_w - partyLab.frame.size.width -15, [common checkStrValue:self.listFri.meetingServiceFacility], 14)
    
    UILabel *partyConLab = [[UILabel alloc]initWithFrame:CGRectMake(partyLab.mj_w + 5, facilityConLab.mj_h + facilityConLab.mj_y, self.view.mj_w - partyLab.frame.size.width -15, parSize.height+10)];
    partyConLab.font = [UIFont systemFontOfSize:14.0];
    partyConLab.numberOfLines = 0;
    partyConLab.textColor = COMColor(51, 51, 51, 1.0);
    partyConLab.textAlignment = NSTextAlignmentRight;
    partyConLab.text = [common checkStrValue:self.listFri.meetingServiceFacility];
    //    self.partyConLab = partyConLab;
    
    [secondSection  addSubview:partyLab];
    [secondSection  addSubview:partyConLab];
    
    UILabel *hotelLab = [[UILabel alloc]initWithFrame:CGRectMake(5, partyConLab.mj_h + partyConLab.mj_y, 120, 30)];
    hotelLab.text = @"酒店餐饮设施：";
    hotelLab.font = [UIFont systemFontOfSize:14.0];
    hotelLab.textColor = COMColor(51, 51, 51, 1.0);
    hotelLab.textAlignment = NSTextAlignmentLeft;
    self.hotelLab = hotelLab;
    
    CGSize hoteHigh =STRING_SIZE_FONT_HEIGHT(self.view.mj_w - hotelLab.frame.size.width -15, [common checkStrValue:self.listFri.diningFacilitity], 14)
    
    UILabel *hotelConLab = [[UILabel alloc]initWithFrame:CGRectMake(hotelLab.mj_w + 5, partyConLab.mj_h + partyConLab.mj_y, self.view.mj_w - hotelLab.frame.size.width -15, hoteHigh.height+10)];
    hotelConLab.font = [UIFont systemFontOfSize:14.0];
    hotelConLab.textColor = COMColor(51, 51, 51, 1.0);
    hotelConLab.textAlignment = NSTextAlignmentRight;
    hotelConLab.numberOfLines = 0;
    hotelConLab.text = [common checkStrValue:self.listFri.diningFacilitity];//场地餐饮设施
    self.hotelConLab = hotelConLab;
    
    [secondSection  addSubview:hotelLab];
    [secondSection  addSubview:hotelConLab];
    
    UILabel *serveLab = [[UILabel alloc]initWithFrame:CGRectMake(5, hotelConLab.mj_h + hotelConLab.mj_y, 120, 30)];
    serveLab.text = @"客房设施服务：";
    serveLab.font = [UIFont systemFontOfSize:14.0];
    serveLab.textColor = COMColor(51, 51, 51, 1.0);
    serveLab.textAlignment = NSTextAlignmentLeft;
    self.serveLab = serveLab;
    
    CGSize size =STRING_SIZE_FONT_HEIGHT(self.view.mj_w - serveLab.frame.size.width -15, [common checkStrValue:self.listFri.roomFacilityService], 14)
    
    UILabel *serveConLab = [[UILabel alloc]initWithFrame:CGRectMake(serveLab.mj_w + 5, hotelConLab.mj_h + hotelConLab.mj_y, self.view.mj_w - serveLab.frame.size.width -15, size.height+10)];
    serveConLab.font = [UIFont systemFontOfSize:14.0];
    serveConLab.textColor = COMColor(51, 51, 51, 1.0);
    serveConLab.textAlignment = NSTextAlignmentRight;
    serveConLab.numberOfLines = 0;
    serveConLab.text = [common checkStrValue:self.listFri.roomFacilityService];
    self.serveConLab = serveConLab;
    
    [secondSection  addSubview:serveLab];
    [secondSection  addSubview:serveConLab];
    
    UILabel *beforeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, serveConLab.mj_h + serveConLab.mj_y, 120, 30)];
    beforeLab.text = @"曾举办会议：";
    beforeLab.font = [UIFont systemFontOfSize:14.0];
    beforeLab.textColor = COMColor(51, 51, 51, 1.0);
    beforeLab.textAlignment = NSTextAlignmentLeft;
    self.beforeLab = beforeLab;
    
    CGSize befSize =STRING_SIZE_FONT_HEIGHT(self.view.mj_w - beforeLab.frame.size.width -15, [common checkStrValue:self.listFri.meetingHistory], 14)
    
    UILabel *beforeConLab = [[UILabel alloc]initWithFrame:CGRectMake(beforeLab.mj_w + 5, serveConLab.mj_h + serveConLab.mj_y, self.view.mj_w - beforeLab.frame.size.width -15, befSize.height)];
    beforeConLab.font = [UIFont systemFontOfSize:14.0];
    beforeConLab.textColor = COMColor(51, 51, 51, 1.0);
    beforeConLab.textAlignment = NSTextAlignmentRight;
    beforeConLab.numberOfLines = 0;
    beforeConLab.text = [common checkStrValue:self.listFri.meetingHistory];
    self.beforeConLab = beforeConLab;
    
    [secondSection  addSubview:beforeLab];
    [secondSection addSubview:beforeConLab];
    [secondSection  addSubview:guestPriceConLab];
    
    
    secondSection.frame =CGRectMake(0, detailView.mj_y + detailView.mj_h + 10, self.view.mj_w, guestConLab.mj_h+guestPriceConLab.mj_h+facilityConLab.mj_h+partyConLab.mj_h+hotelConLab.mj_h+serveConLab.mj_h+beforeConLab.mj_h+10);
    self.secondSection = secondSection;
    [sc addSubview:secondSection];
    
    sc.contentSize = CGSizeMake(0,Imsection.mj_h+detailView.mj_h+secondSection.mj_h+30);
    self.sc = sc;
    [self.view addSubview:sc];
}
- (void)detailClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.listFri.proDescription;
    [self.navigationController pushViewController:achVC animated:YES];
}

- (void)postBtnAction:(UIButton *)sender
{
    DEF_ZHAOPLACEENQUIRY;
    PriceViewController *priceVC = [[PriceViewController alloc] init];
    priceVC.strID = self.listFri.roadId;
    [self.navigationController pushViewController:priceVC animated:YES];
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
