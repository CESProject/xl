//
//  PartnerViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/12.
//  Copyright © 2016年 王文静. All rights reserved.
//**************  合作   ********************

#import "PartnerViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+MJExtension.h"
#import "common.h"
#import "TenderViewController.h"
#import "NewsViewController.h"
#import "Object.h"
#import "CommentsTableViewCell.h"
#import "Result.h"
#import "NSDate+Utilities.h"
#import "PersonalViewController.h"
#import "AchievementViewController.h"
@interface PartnerViewController ()<UITableViewDataSource,UITableViewDelegate,WJSliderViewDelegate,UITextFieldDelegate>
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
@property (nonatomic , strong) UIButton *signUpBtn; // 报名

@property (nonatomic , strong) UILabel *rightLab; //项目方向
@property (nonatomic , strong) UILabel *rightConLab;
// 一句简述
@property (nonatomic , strong) UILabel *sketchLab;
@property (nonatomic , strong) UILabel *sketchConLab;
// 项目赏金
@property (nonatomic , strong) UILabel *moneyLab;
@property (nonatomic , strong) UILabel *moneyConLab;
// 投标截止日期
@property (nonatomic , strong) UILabel *tenderLab;
@property (nonatomic , strong) UILabel *tenderConLab;
// 项目截止日期
@property (nonatomic , strong) UILabel *projectLab;
@property (nonatomic , strong) UILabel *projectConLab;

@property (nonatomic , strong) UILabel *introLab;
@property (nonatomic , strong) UIView *lineintro;
//@property (nonatomic , strong) UILabel *introConLab;
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

@implementation PartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.title = self.listFd.name;
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.hud = [common createHud];
    self.currentPage = 1;
    _cellNumArr = [NSMutableArray array];
    [self loadRequestDetailView];
}
- (void)loadRequestDetailView
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTDETAIL params:@{@"id":self.listFd.roadId,@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {

        if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
        {
            Object *obj = [Object objectWithKeyValues:result[@"obj"]];
            weakSelf.objec = obj;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^{
                //获取关注状态
//                WEAKSELF;
//                [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUGUANZHU params:@{@"otherUserId":DEF_USERID} complete:^(BOOL successed, NSDictionary *result) {
//                    if (successed)
//                    {
//                        NSString *rela =result[@"obj"][@"isRelation"];
//                        relation = [rela intValue];
//                        if ([result[@"code"] isEqualToString:@"10000"]) {
//                            if ([rela isEqualToString:@"1"]) {
//                                weakSelf.focusLab.text =@"关注";                                }else
//                                {
//                                    weakSelf.focusLab.text =@"取消关注";
//                                }
//                        }
//                    }
//                }];
                //获取点赞状态
                [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUDIANZAN params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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
            [self initView];
            [self headerRefreshing];
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
    
    /**
     * 获取留言
     */
//    [self loadNoteList];
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [comTableView.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
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
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
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

//- (void)loadNoteList
//{
//    /**
//     * 获取留言
//     */
//    WEAKSELF;
//    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9",@"pageNumber": @(1),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
//        if (successed)
//        {
//            Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
//            weakSelf.results = resul;
//            [comTableView reloadData];
//            
//        }
//    }];
//}
//- (void)searchMesage
//{
    //    [MHNetworkManager postReqeustWithURL:DEF_XMCHAXUNTOUBIAO params:@{@"id":self.listFd.roadId} successBlock:^(NSDictionary *returnData) {
    //        NSLog(@"---===>%@",returnData);
    //    } failureBlock:^(NSError *error) {
    //
    //    } showHUD:YES];
//}
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
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [signUpBtn setTitle:@"我要投标" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(signUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.layer.masksToBounds = YES;
    signUpBtn.layer.cornerRadius = 4;
    signUpBtn.layer.borderWidth = 1;
    signUpBtn.tintColor = GREENCOLOR;
    signUpBtn.layer.borderColor = GREENCOLOR.CGColor;
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    signUpBtn.hidden = YES;
    self.signUpBtn = signUpBtn;
    [sc addSubview:signUpBtn];
    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = @"外包已结束";
//    lab.font = [UIFont systemFontOfSize:13];
//    lab.textColor = [UIColor redColor];
//    lab.hidden = YES;
//    [sc addSubview:lab];
//    lab.textAlignment = NSTextAlignmentCenter;
//    self.endLab = lab;
    
    
    self.sc = sc;
    [self.view addSubview:sc];
    
}

- (void)msgBtnAction:(UIButton *)sender
{
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    newsVC.userInfoId = self.objec.userInfo.roadId;
    [self.navigationController pushViewController:newsVC animated:YES];
}
- (void)signUpBtnAction:(UIButton *)sender
{
    TenderViewController *tendVC = [[TenderViewController alloc]init];
    tendVC.objct = self.objec;
    [self.navigationController pushViewController:tendVC animated:YES];
}
- (void)focusClick
{
    if (relation%2==1)
    {
        self.focusLab.text = @"取消关注";
        NSString *url = [NSString stringWithFormat:@"%@/%@",DEF_TIANJIAGZ,self.objec.userInfo.roadId];
        [[HttpManager defaultManager] getRequestToUrl:url params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    
                }else
                {
                    [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }else
    {
        self.focusLab.text = @"关注";
        NSString *nourl = [NSString stringWithFormat:@"%@/%@",DEF_QUXIAOGZ,self.objec.userInfo.roadId];
        [[HttpManager defaultManager] getRequestToUrl:nourl params:nil complete:^(BOOL successed, NSDictionary *result) {
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"]) {
                    
                }else
                {
                   [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
                }
            }
        }];
    }
    relation ++;
}
- (void)praiseBtnActi:(UIButton *)sender
{
    if (selectNum%2==1) {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_DIANZAN params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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
        [[HttpManager defaultManager] postRequestToUrl:DEF_QUXIAODIANZAN params:@{@"businessId":self.listFd.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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

- (void)initData
{
    
//    CGSize sizeTitle = [common sizeWithString:@"" font:[UIFont systemFontOfSize:20.0f] maxSize:CGSizeMake(self.view.mj_w - 40, 0)];
    
   
    
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
//    self.addBtn.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 5, self.line.mj_h + self.line.mj_y + 5, 25, 25);
//    self.focusLab.frame = CGRectMake(self.addBtn.mj_x + self.addBtn.mj_w, self.line.mj_h + self.line.mj_y + 8, 100, 25);
//    self.msgBtn.frame = CGRectMake(self.view.mj_w  - 100, self.line.mj_h + self.line.mj_y + 8, 25, 25);
//    self.msgLab.frame = CGRectMake(self.msgBtn.mj_w + self.msgBtn.mj_x, self.msgBtn.mj_y, 50, 25);
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
    self.signUpBtn.frame = CGRectMake(self.view.mj_w - 80 , self.im.mj_y + self.im.mj_h + 20, 70, 25);
//    self.endLab.frame = CGRectMake(DEF_SCREEN_WIDTH/2, self.im.mj_y + self.im.mj_h + 20, DEF_SCREEN_WIDTH/2, 25);
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 10, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.sc addSubview:grayView];
    
    
    
    self.detailView = [UIView new];
    self.notesView = [UIView new];
    //////////  详情  ///////////////////////////
    
    UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    rightLab.text = @"项目所在地：";
    rightLab.font = [UIFont systemFontOfSize:14.0];
    rightLab.textColor = [UIColor lightGrayColor];
    rightLab.textAlignment = NSTextAlignmentRight;
    self.rightLab = rightLab;
    
    UILabel *rightConLab = [[UILabel alloc]initWithFrame:CGRectMake([rightLab right]+10, 0, self.view.mj_w - rightLab.frame.size.width -10, 30)];
    rightConLab.text = [NSString stringWithFormat:@"%@   %@",[common checkStrValue:self.objec.provinceName],[common checkStrValue:self.objec.cityName]];
    rightConLab.font = [UIFont systemFontOfSize:14.0];
    rightConLab.textColor = COMColor(51, 51, 51, 1.0);
    rightConLab.textAlignment = NSTextAlignmentLeft;
    self.rightConLab = rightConLab;
    
    [self.detailView  addSubview:rightLab];
    [self.detailView  addSubview:rightConLab];
    
    // 手机:
    UILabel *sketchLab = [[UILabel alloc]initWithFrame:CGRectMake(rightLab.mj_x, rightConLab.mj_h + rightConLab.mj_y , 100, 30)];
    sketchLab.text = @"发布时间：";
    sketchLab.font = [UIFont systemFontOfSize:14.0];
    sketchLab.textColor = [UIColor lightGrayColor];
    sketchLab.textAlignment = NSTextAlignmentRight;
    self.sketchLab = sketchLab;
    
    UILabel *sketchConLab = [[UILabel alloc]initWithFrame:CGRectMake([sketchLab right]+10, rightConLab.mj_h + rightConLab.mj_y, self.view.mj_w - rightLab.frame.size.width -10, 30)];
    sketchConLab.text = [common sectionStrByCreateTime:self.objec.createDate];
    sketchConLab.font = [UIFont systemFontOfSize:14.0];
    sketchConLab.textColor = COMColor(51, 51, 51, 1.0);
    sketchConLab.textAlignment = NSTextAlignmentLeft;
    self.sketchConLab = sketchConLab;
    
    [self.detailView  addSubview:sketchLab];
    [self.detailView  addSubview:sketchConLab];
    
   
    
  
    
    //简要说明:
    UILabel *projectLab = [[UILabel alloc]initWithFrame:CGRectMake(rightLab.mj_x, sketchConLab.mj_h + sketchConLab.mj_y, 100, 30)];
    projectLab.text = @"项目方向：";
    projectLab.font = [UIFont systemFontOfSize:14.0];
    projectLab.textColor = [UIColor lightGrayColor];
    projectLab.textAlignment = NSTextAlignmentRight;
    self.projectLab = projectLab;
    
    UILabel *projectConLab = [[UILabel alloc]initWithFrame:CGRectMake(projectLab.frame.size.width+10, sketchConLab.mj_h + sketchConLab.mj_y, sketchConLab.mj_w, 30)];
    projectConLab.text = self.objec.typeName;
    projectConLab.font = [UIFont systemFontOfSize:14.0];
    projectConLab.textColor = COMColor(51, 51, 51, 1.0);
    projectConLab.textAlignment = NSTextAlignmentLeft;
    self.projectConLab = projectConLab;
    
    [self.detailView  addSubview:projectLab];
    [self.detailView  addSubview:projectConLab];
    
    
    UILabel *tenderLab = [[UILabel alloc]initWithFrame:CGRectMake(0, projectConLab.mj_h + projectConLab.mj_y, 100, 30)];
    tenderLab.text = @"项目阶段：";
    tenderLab.font = [UIFont systemFontOfSize:14.0];
    tenderLab.textColor = [UIColor lightGrayColor];
    tenderLab.textAlignment = NSTextAlignmentRight;
    self.tenderLab = tenderLab;
    
    UILabel *tenderConLab = [[UILabel alloc]initWithFrame:CGRectMake([tenderLab right]+10,  projectConLab.mj_h + projectConLab.mj_y, self.view.mj_w - tenderLab.frame.size.width -10, 30)];
    tenderConLab.text = [NSString stringWithFormat:@"%@",self.stageArr[self.objec.cooperationStage]];
    tenderConLab.font = [UIFont systemFontOfSize:14.0];
    tenderConLab.textColor = COMColor(51, 51, 51, 1.0);
    tenderConLab.textAlignment = NSTextAlignmentLeft;
    self.tenderConLab = tenderConLab;
    
    [self.detailView  addSubview:tenderLab];
    [self.detailView  addSubview:tenderConLab];
    
    
    UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, tenderConLab.mj_h + tenderConLab.mj_y , 100, 30)];
    moneyLab.text = @"初始资金：";
    moneyLab.font = [UIFont systemFontOfSize:14.0];
    moneyLab.textColor =[UIColor lightGrayColor];
    moneyLab.textAlignment = NSTextAlignmentRight;
    self.moneyLab = moneyLab;
    
    UILabel *moneyConLab = [[UILabel alloc]initWithFrame:CGRectMake(moneyLab.mj_w+10,  tenderLab.mj_h + tenderLab.mj_y, self.view.mj_w - rightLab.frame.size.width -10, 30)];

    NSString *str = [NSString stringWithFormat:@"%@",self.objec.cszijin];
    if (![str isEqualToString:@"<null>"]&& ![str isEqualToString:@""] && ![str isEqualToString:@"(null)"])
    {
         moneyConLab.text = [NSString stringWithFormat:@"%@元",self.objec.cszijin];
        
    }
    else
    {
     
        moneyConLab.text = @"0元";
    }
    
    moneyConLab.font = [UIFont systemFontOfSize:14.0];
    moneyConLab.textColor = COMColor(51, 51, 51, 1.0);
    moneyConLab.textAlignment = NSTextAlignmentLeft;
    self.moneyConLab = moneyConLab;
    
    [self.detailView  addSubview:moneyLab];
    [self.detailView  addSubview:moneyConLab];
    
    UIView *grayView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.moneyConLab.mj_h + self.moneyConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView2.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView2];
    
    
    // 联系人:
    UILabel *personLab = [[UILabel alloc]initWithFrame:CGRectMake(0, moneyConLab.mj_y + moneyConLab.mj_h + 20, 100, 30)];
    personLab.text = @"联系人：";
    personLab.font = [UIFont systemFontOfSize:14.0];
    personLab.textColor = COMColor(51, 51, 51, 1.0);
    personLab.textAlignment = NSTextAlignmentRight;
    personLab.textColor = [UIColor lightGrayColor];
    
    
    UILabel *personConLab = [[UILabel alloc]initWithFrame:CGRectMake(personLab.mj_w + 10, moneyConLab.mj_y + moneyConLab.mj_h + 20, self.view.mj_w - personLab.frame.size.width -20, 30)];
    personConLab.text = self.objec.linkman;
    personConLab.textColor = [UIColor grayColor];
    personConLab.font = [UIFont systemFontOfSize:14.0];
    personConLab.textAlignment = NSTextAlignmentLeft;
  
    
    [self.detailView  addSubview:personLab];
    [self.detailView  addSubview:personConLab];
    self.personLab = personLab;
      self.personConLab = personConLab;
    
    // 手机:
    UILabel *mobileLab = [[UILabel alloc]initWithFrame:CGRectMake(0, personConLab.mj_h + personConLab.mj_y , 100, 30)];
    mobileLab.text = @"手机：";
    mobileLab.font = [UIFont systemFontOfSize:14.0];
    mobileLab.textColor = COMColor(51, 51, 51, 1.0);
    mobileLab.textAlignment = NSTextAlignmentRight;
    mobileLab.textColor = [UIColor lightGrayColor];
   
    
    UILabel *mobileConLab = [[UILabel alloc]initWithFrame:CGRectMake(mobileLab.mj_w + 10, personConLab.mj_h + personConLab.mj_y + 1, self.view.mj_w - mobileLab.mj_w -20, 30)];
    mobileConLab.text = self.objec.cellphone;
//    mobileConLab.textColor = [UIColor lightGrayColor];
    mobileConLab.font = [UIFont systemFontOfSize:14.0];
    mobileConLab.textAlignment = NSTextAlignmentLeft;
   
    
    [self.detailView  addSubview:mobileLab];
    [self.detailView  addSubview:mobileConLab];
     self.mobileLab = mobileLab;
     self.mobileConLab = mobileConLab;
    
    //     固定电话:
    UILabel *cellphoneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, mobileConLab.mj_h + mobileConLab.mj_y + 1, 100, 30)];
    cellphoneLab.text = @"固定电话：";
    cellphoneLab.font = [UIFont systemFontOfSize:14.0];
    cellphoneLab.textColor = COMColor(51, 51, 51, 1.0);
    cellphoneLab.textAlignment = NSTextAlignmentRight;
    cellphoneLab.textColor = [UIColor lightGrayColor];
    
    
    UILabel *cellphConLab = [[UILabel alloc]initWithFrame:CGRectMake(cellphoneLab.mj_w + 10, mobileConLab.mj_h + mobileConLab.mj_y + 1, self.view.mj_w - cellphoneLab.mj_w -20, 30)];
    cellphConLab.font = [UIFont systemFontOfSize:14.0];
//    cellphConLab.textColor = [UIColor lightGrayColor];
    cellphConLab.textAlignment = NSTextAlignmentLeft;
    cellphConLab.text = self.objec.telephone;
   
    
    [self.detailView  addSubview:cellphoneLab];
    [self.detailView  addSubview:cellphConLab];
    self.cellphoneLab = cellphoneLab;
     self.cellphConLab = cellphConLab;
    
    // 邮箱:
    UILabel *emailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, cellphConLab.mj_h + cellphConLab.mj_y +1, 100, 30)];
    emailLab.text = @"邮箱：";
    emailLab.font = [UIFont systemFontOfSize:14.0];
    emailLab.textColor = COMColor(51, 51, 51, 1.0);
    emailLab.textColor = [UIColor lightGrayColor];
    emailLab.textAlignment = NSTextAlignmentRight;
    
    
    UILabel *emailConLab = [[UILabel alloc]initWithFrame:CGRectMake(emailLab.mj_w + 10,  cellphConLab.mj_h + cellphConLab.mj_y, self.view.mj_w - cellphoneLab.mj_w -20, 30)];
    emailConLab.font = [UIFont systemFontOfSize:14.0];
    emailConLab.textColor = [UIColor lightGrayColor];
    emailConLab.textAlignment = NSTextAlignmentLeft;
    emailConLab.text = self.objec.email;
    
    
    [self.detailView  addSubview:emailLab];
    [self.detailView  addSubview:emailConLab];
    self.emailLab = emailLab;
    self.emailConLab = emailConLab;
    
    // QQ:
    UILabel *qqLab = [[UILabel alloc]initWithFrame:CGRectMake(0, emailConLab.mj_h + emailConLab.mj_y + 1, 100, 30)];
    qqLab.text = @"QQ：";
    qqLab.font = [UIFont systemFontOfSize:14.0];
    qqLab.textColor = COMColor(51, 51, 51, 1.0);
    qqLab.textAlignment = NSTextAlignmentRight;
    qqLab.textColor = [UIColor lightGrayColor];
    
    
    UILabel *qqConLab = [[UILabel alloc]initWithFrame:CGRectMake(qqLab.mj_w + 10 ,  emailConLab.mj_h + emailConLab.mj_y + 1, self.view.mj_w - qqLab.mj_w -20, 30)];
    qqConLab.font = [UIFont systemFontOfSize:14.0];
//    qqConLab.textColor = [UIColor lightGrayColor];
    qqConLab.textAlignment = NSTextAlignmentLeft;
    qqConLab.text = self.objec.qq;
    
    
    [self.detailView  addSubview:qqLab];
    [self.detailView  addSubview:qqConLab];
    self.qqLab = qqLab;
    self.qqConLab = qqConLab;
    
    UIView *grayView3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.qqConLab.mj_h + self.qqConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView3.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView3];
    
    UILabel *introLab = [[UILabel alloc]initWithFrame:CGRectMake(10, qqConLab.mj_y + qqConLab.mj_h + 25, 70, 30)];
    introLab.text = @"项目简介：";
    introLab.font = [UIFont systemFontOfSize:14.0];
    introLab.textColor = [UIColor lightGrayColor];
    introLab.textAlignment = NSTextAlignmentLeft;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake([introLab right], introLab.mj_y,100, introLab.mj_h);
    [but addTarget:self action:@selector(jianjiedetailClick) forControlEvents:UIControlEventTouchUpInside];
    but.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [but setTitle:@"点击查看详情" forState:UIControlStateNormal];
    but.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.detailView addSubview:but];
//    UIView *lineintro = [[UIView alloc]initWithFrame:CGRectMake(10, introLab.mj_y + introLab.mj_h, self.view.mj_w - 20, 1)];
//    lineintro.backgroundColor =  [UIColor lightGrayColor];
//    
//    UILabel *introConLab = [[UILabel alloc]init];
//    introConLab.numberOfLines = 0;
//    introConLab.text = self.objec.proDescription;
//    introConLab.font = [UIFont systemFontOfSize:14.0];
//    
//
//    if (!self.objec.proDescription || [self.objec.proDescription isEqualToString:@""]) {
//        size1 = CGSizeMake(DEF_SCREEN_WIDTH-20, 30);
//        introConLab.frame = CGRectMake(10, introLab.mj_h + introLab.mj_y + 1, self.view.mj_w - 20, 30);
//        
//    }
//    else
//    {
//        size1 = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH - 20, self.objec.proDescription, 14.0);
//        if (size1.height < 30) {
//            size1.height = 30;
//        }
//        introConLab.frame = CGRectMake(10, introLab.mj_h + introLab.mj_y + 1, DEF_SCREEN_WIDTH-20, size1.height);
//        
//    }
    
    
    [self.detailView addSubview:introLab];
//    [self.detailView addSubview:lineintro];
//    [self.detailView addSubview:introConLab];
    self.introLab = introLab;
//    self.introConLab = introConLab;
//    self.lineintro = lineintro;
    
    UIView *grayView4 = [[UIView alloc]initWithFrame:CGRectMake(0, introLab.mj_h + introLab.mj_y + 10, self.view.mj_w, 5)];
    grayView4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView4];
    
    
    UILabel *panterLab = [[UILabel alloc]initWithFrame:CGRectMake(10, introLab.mj_y + introLab.mj_h + 25, self.view.mj_w - 20, 30)];
    panterLab.text = @"合伙人：";
    panterLab.font = [UIFont systemFontOfSize:14.0];
    panterLab.textColor = [UIColor lightGrayColor];
    panterLab.textAlignment = NSTextAlignmentLeft;
    UIView *line7 = [[UIView alloc]initWithFrame:CGRectMake(10, panterLab.mj_y + panterLab.mj_h, self.view.mj_w - 20, 1)];
    line7.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *panterConLab = [[UILabel alloc]init];
    
    

    if (!self.objec.type || [self.objec.type isEqualToString:@""]) {
        
        panterConLab.frame = CGRectMake(10, panterLab.mj_h + panterLab.mj_y + 1, self.view.mj_w - 20, 30);
        
    }
    else
    {
        size7 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w  -20, self.panterArr[self.objec.type.intValue], 14.0);
        if (size7.height < 30)
        {
            size7.height = 30;
        }
        panterConLab.frame =CGRectMake(10, panterLab.mj_h + panterLab.mj_y + 1, self.view.mj_w - 20, size7.height);
        
    }
    panterConLab.text = self.panterArr[self.objec.type.intValue];
    panterConLab.font = [UIFont systemFontOfSize:14.0];
    self.panterLab = panterLab;
    self.panterConLab = panterConLab;
    self.line7 = line7;
    [self.detailView addSubview:panterLab];
    [self.detailView addSubview:line7];
    [self.detailView addSubview:panterConLab];
    
    
    UIView *grayView5 = [[UIView alloc]initWithFrame:CGRectMake(0, panterConLab.mj_h + panterConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView5.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView5];
    
    
    UILabel *annexLab = [[UILabel alloc]initWithFrame:CGRectMake(10, panterConLab.mj_y + panterConLab.mj_h + 25, self.view.mj_w - 20, 30)];
    annexLab.text = @"市场前景：";
    annexLab.font = [UIFont systemFontOfSize:14.0];
    annexLab.textColor = [UIColor lightGrayColor];
    annexLab.textAlignment = NSTextAlignmentLeft;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(10, annexLab.mj_y + annexLab.mj_h, self.view.mj_w - 20, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *annexConLab = [[UILabel alloc]init];
    annexConLab.frame = CGRectMake(10, annexLab.mj_h + annexLab.mj_y + 1, self.view.mj_w - 20, 30);
    annexConLab.font = [UIFont systemFontOfSize:14.0];
//    CGSize size3 ;
    if (!self.objec.prospectYear || self.objec.prospectYear==0)
    {
        annexConLab.text = @"";
    }else
    {
        annexConLab.text = [NSString stringWithFormat:@"预计%d年，项目估值在%d万元",self.objec.prospectYear,self.objec.prospectMoney];
    }
    
//    {
//        size3 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.introLab.mj_w -10, @"", 14.0);
//        if (size3.height < 30)
//        {
//            size3.height = 30;
//        }
//        annexConLab.frame = CGRectMake(10, annexLab.mj_h + annexLab.mj_y + 1, self.view.mj_w - 20, size3.height);
//        
//    }

    self.annexLab = annexLab;
    self.line3 = line3;
    self.annexConLab = annexConLab;
    [self.detailView addSubview:annexLab];
    [self.detailView addSubview:line3];
    [self.detailView addSubview:annexConLab];
    
    UIView *grayView6 = [[UIView alloc]initWithFrame:CGRectMake(0, annexConLab.mj_h + annexConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView6.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView6];
    
    
    UILabel *competeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, annexConLab.mj_y + annexConLab.mj_h + 25, self.view.mj_w - 20, 30)];
    competeLab.text = @"竞争优势：";
    competeLab.font = [UIFont systemFontOfSize:14.0];
    competeLab.textColor = [UIColor lightGrayColor];
    competeLab.textAlignment = NSTextAlignmentLeft;
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(10, competeLab.mj_y + competeLab.mj_h, self.view.mj_w - 20, 1)];
    line4.backgroundColor = [UIColor lightGrayColor];
    
    
    UILabel *competeConLab = [[UILabel alloc]init];
    
    
    if (!self.objec.advantage || [self.objec.advantage isEqualToString:@""]) {
        
        competeConLab.frame = CGRectMake(10, competeLab.mj_h + competeLab.mj_y + 1, self.view.mj_w - 20, 30);
        
    }
    else
    {
        size4 = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.objec.advantage, 14.0);
        if (size4.height < 30) {
            size4.height = 30;
        }
        competeConLab.frame = CGRectMake(10, competeLab.mj_h + competeLab.mj_y + 1, self.view.mj_w - 20, size4.height);
        
    }
    competeConLab.text = self.objec.advantage;
    competeConLab.font = [UIFont systemFontOfSize:14.0];
    self.competeLab = competeLab;
    self.competeConLab = competeConLab;
    self.line4 = line4;
    [self.detailView addSubview:competeLab];
    [self.detailView addSubview:line4];
    [self.detailView addSubview:competeConLab];
    
    UIView *grayView7 = [[UIView alloc]initWithFrame:CGRectMake(0, competeConLab.mj_h + competeConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView7.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView7];
    
    
    UILabel *pointLab = [[UILabel alloc]initWithFrame:CGRectMake(10, competeConLab.mj_y + competeConLab.mj_h + 25, self.view.mj_w - 20, 30)];
    pointLab.text = @"项目要求：";
    pointLab.font = [UIFont systemFontOfSize:14.0];
    pointLab.textColor = [UIColor lightGrayColor];
    pointLab.textAlignment = NSTextAlignmentLeft;
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(10, pointLab.mj_y + pointLab.mj_h, self.view.mj_w - 20, 1)];
    line5.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *pointConLab = [[UILabel alloc]init];
    pointConLab.frame = CGRectMake(10, pointLab.mj_h + pointLab.mj_y + 1, self.view.mj_w - 20, 30);
    pointConLab.font = [UIFont systemFontOfSize:14.0];
//    CGSize size5 ;
    if (!self.objec.teamNum || [self.objec.teamNum isEqualToString:@""]) {
            pointConLab.text =@"";
        }else
        {
            pointConLab.text = [NSString stringWithFormat:@"团队人数：%@ 全职人数：%@",self.objec.teamNum,self.objec.fullTimeNum];
        }
//    else
//    {
//        size5 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.introLab.mj_w -10, self.objec.proDescription, 14.0);
//        if (size5.height < 30) {
//            size5.height = 30;
//        }
//        pointConLab.frame = CGRectMake(10, pointLab.mj_h + pointLab.mj_y + 1, self.view.mj_w - 20, 30);
//        
//    }
    self.pointLab = pointLab;
    self.pointConLab = pointConLab;
    self.line5 = line5;
    [self.detailView addSubview:pointLab];
    [self.detailView addSubview:line5];
    [self.detailView addSubview:pointConLab];
    
    
    UIView *grayView8 = [[UIView alloc]initWithFrame:CGRectMake(0, pointConLab.mj_h + pointConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView8.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView8];
    
    UILabel *declarerLab = [[UILabel alloc]initWithFrame:CGRectMake(10, pointConLab.mj_y + pointConLab.mj_h + 25, self.view.mj_w - 20, 30)];
    declarerLab.text = @"召唤宣言：";
    declarerLab.font = [UIFont systemFontOfSize:14.0];
    declarerLab.textColor = [UIColor lightGrayColor];
    declarerLab.textAlignment = NSTextAlignmentLeft;
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(10, declarerLab.mj_y + declarerLab.mj_h, self.view.mj_w - 20, 1)];
    line6.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *declarerConLab = [[UILabel alloc]init];
    declarerConLab.numberOfLines = 0;
    
    if (!self.objec.declaration || [self.objec.declaration isEqualToString:@""]) {
        
        declarerConLab.frame = CGRectMake(10, declarerLab.mj_h + declarerLab.mj_y + 1, DEF_SCREEN_WIDTH - 20, 30);
        
    }
    else
    {
        size6 = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.objec.declaration, 14.0);
        if (size6.height < 30) {
            size6.height = 30;
        }
        declarerConLab.frame =CGRectMake(10, declarerLab.mj_h + declarerLab.mj_y + 1, DEF_SCREEN_WIDTH - 20, size6.height);
        
    }
    declarerConLab.text = self.objec.declaration;
    declarerConLab.font = [UIFont systemFontOfSize:14.0];
    
    self.declarerLab = declarerLab;
    self.declarerConLab = declarerConLab;
    self.line6 = line6;
    [self.detailView addSubview:declarerLab];
    [self.detailView addSubview:line6];
    [self.detailView addSubview:declarerConLab];
    
    UIView *grayView9 = [[UIView alloc]initWithFrame:CGRectMake(0, declarerConLab.mj_h + declarerConLab.mj_y + 10, self.view.mj_w, 5)];
    grayView9.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView9];
    
    UILabel *requestLab = [[UILabel alloc]initWithFrame:CGRectMake(10, declarerConLab.mj_y + declarerConLab.mj_h + 25, 70, 30)];
    requestLab.text = @"详细说明：";
    requestLab.font = [UIFont systemFontOfSize:14.0];
    requestLab.textColor = [UIColor lightGrayColor];
    requestLab.textAlignment = NSTextAlignmentLeft;
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeSystem];
    butn.frame = CGRectMake([requestLab right], requestLab.mj_y,100, requestLab.mj_h);
    [butn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    butn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [butn setTitle:@"点击查看详情" forState:UIControlStateNormal];
    butn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.btn = butn;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, requestLab.mj_y + requestLab.mj_h, self.view.mj_w - 20, 1)];
    line2.backgroundColor =  [UIColor lightGrayColor];
    
    
//    UILabel *requestConLab = [[UILabel alloc]init];
//    CGSize size2 ;
//    if (!self.objec.demand || [self.objec.demand isEqualToString:@""]) {
//        
//        requestConLab.frame = CGRectMake(10, requestLab.mj_h + requestLab.mj_y + 1, self.view.mj_w - 20, 30);
//        
//    }
//    else
//    {
//        size2 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.introLab.mj_w -10, self.objec.demand, 14.0);
//        if (size2.height < 30) {
//            size2.height = 30;
//        }
//        requestConLab.frame = CGRectMake(10, requestLab.mj_h + requestLab.mj_y + 1, self.view.mj_w - 20, 30);
//        
//    }
//    
//    requestConLab.numberOfLines = 0;
//    requestConLab.text = self.objec.demand;
    
    self.requestLab = requestLab;
//    self.requestConLab = requestConLab;
    self.line2 =line2;
    [self.detailView addSubview:requestLab];
    [self.detailView addSubview:butn];
    [self.detailView addSubview:line2];
//    [self.detailView addSubview:requestConLab];

  
    
    
    
    //////////  详情  ///////////////////////////
    //////////  留言  ///////////////////////////
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 90 )];
    commentView.backgroundColor = [UIColor whiteColor];
    
    
    
    UITextField *commentText = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width  - 20, 40)];
    commentText.placeholder = @"请输入留言内容";
    commentText.borderStyle = UITextBorderStyleRoundedRect;
    commentText.delegate = self;
    self.commentText = commentText;
    [commentView addSubview:commentText];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(self.view.mj_w - 80, self.commentText.mj_y + self.commentText.mj_h + 5, 60, 30);
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 4;
    sendBtn.layer.borderWidth = 1;
    sendBtn.tintColor = GREENCOLOR;
    sendBtn.layer.borderColor = GREENCOLOR.CGColor;
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn = sendBtn;
    [commentView addSubview:sendBtn];
    
    
    UIButton *publicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [publicBtn setFrame:CGRectMake(self.view.mj_w - 240, sendBtn.mj_y + 5, 20, 20)];
    [publicBtn addTarget:self action:@selector(publicBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.publicBtn = publicBtn;
    self.publicityType = @"0";
    [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateNormal];
    [self.praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    
    UILabel *publicLab = [[UILabel alloc]initWithFrame:CGRectMake(publicBtn.mj_x + publicBtn.mj_w, publicBtn.mj_y - 5, 40, 30)];
    publicLab.text = @"公开";
    
    [commentView addSubview:publicBtn];
    [commentView addSubview:publicLab];
    
    UIButton *praiteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [praiteBtn setFrame:CGRectMake(publicLab.mj_x + publicLab.mj_w+ 10, sendBtn.mj_y + 5, 20, 20)];
    [praiteBtn addTarget:self action:@selector(praiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.praiteBtn = praiteBtn;
    
    UILabel *praiteLab = [[UILabel alloc]initWithFrame:CGRectMake(praiteBtn.mj_x + praiteBtn.mj_w, publicBtn.mj_y - 5, 40, 30)];
    praiteLab.text = @"私密";
    
    [commentView addSubview:praiteBtn];
    [commentView addSubview:praiteLab];
    
    self.commentView = commentView;
    [self.notesView addSubview:commentView];
    
    UIView *grayView11 = [[UIView alloc]initWithFrame:CGRectMake(0, commentView.mj_y + commentView.mj_h, self.view.mj_w, 5)];
    grayView11.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.notesView addSubview:grayView11];
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.commentView.mj_y + self.commentView.mj_h+5, self.view.mj_w, 50)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *commentNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 70, 40)];
    commentNum.text = @"全部留言";
    self.commentNum = commentNum;
    [sectionView addSubview:commentNum];
//    // 点赞
//    UIButton *prasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [prasBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
//    prasBtn.frame = CGRectMake(self.view.mj_w - 200, 15, 20, 20);
//    self.prasBtn = prasBtn;
//    
//    UILabel *prasNum = [[UILabel alloc]initWithFrame:CGRectMake(self.prasBtn.mj_x + self.prasBtn.mj_w, 5, 70, 40)];
//    prasNum.text = [NSString stringWithFormat:@"%d",self.objec.praiseCount];
//    self.prasNum = prasNum;
    // 评论
    UIButton *comSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comSendBtn.frame = CGRectMake(self.view.mj_w - 90, 10, 30, 30);
    [comSendBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
    self.comSendBtn = comSendBtn;
    UILabel *comSendNum = [[UILabel alloc]initWithFrame:CGRectMake( self.comSendBtn.mj_w + self.comSendBtn.mj_x, 5, self.view.mj_w - self.comSendBtn.mj_w - self.comSendBtn.mj_x - 10, 40)];
    comSendNum.text = self.results.totalElements;
    self.comSendNum = comSendNum;
    
//    [sectionView addSubview:prasBtn];
//    [sectionView addSubview:prasNum];
    [sectionView addSubview:comSendBtn];
    [sectionView addSubview:comSendNum];
    self.sectionView = sectionView;
    [self.notesView addSubview:sectionView];
    UIView *line11 = [[UIView alloc]initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y, sectionView.mj_w, 0.5)];
    line11.backgroundColor = [UIColor lightGrayColor];
    [self.notesView addSubview:line11];
    
    //////////  留言  ///////////////////////////
    
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    
    label1.text = @"详情";
    label2.text = @"留言";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 2, self.view.mj_w, self.view.bounds.size.height / 2) style:UITableViewStylePlain];
    comTableView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [comTableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [self.notesView addSubview:comTableView];
    
    if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
    { //新增判断4s
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size1.height+size7.height+size4.height+size6.height+60) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size1.height+size7.height+size4.height+size6.height+10) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size1.height+size7.height+size4.height+size6.height- 30) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    NSLog(@"%@",[common getCurrentDeviceModel:self]);
    
    UIView *grayView12 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView12.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView12];
   
    self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + size1.height+size7.height+size4.height+size6.height + 300);
    
}
- (void)jianjiedetailClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.objec.proDescription;
    [self.navigationController pushViewController:achVC animated:YES];
}
- (void)detailClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.objec.demand;
    [self.navigationController pushViewController:achVC animated:YES];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIButton Select Action
- (void)sendBtnAction
{
    self.sendBtn.enabled = NO;
    if ([self.commentText.text isEqualToString:@""])
    {
        showAlertView(@"留言内容不能为空");
        self.sendBtn.enabled = YES;
        return;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ADDNOTES params:@{@"receiverId":self.listFd.createBy,@"publicityType":self.publicityType,@"content":self.commentText.text,@"businessId":self.listFd.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"10000"]) {
                [weakSelf headerRefreshing];
                [MBProgressHUD showSuccess:@"留言成功" toView:weakSelf.view];
            }
            else
            {
                showAlertView(@"留言失败");
            }
        }
        else
        {
            showAlertView(@"留言失败");
        }
        self.sendBtn.enabled = YES;
    }];
    
}
- (void)publicBtnAction
{
    self.publicityType = @"0";
    [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateNormal];
    [self.praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
}
- (void)praiteBtnAction
{
    self.publicityType = @"1";
    [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [self.praiteBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateNormal];
}

- (void)titleViewAction:(UIButton *)sender
{
    PersonalViewController *perVC = [[PersonalViewController alloc] init];
    perVC.obj = self.objec;
    [self.navigationController pushViewController:perVC animated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)loadWJSliderViewDidIndex:(NSInteger)index
{
    if (index == 1) {

        self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 145);
        [comTableView reloadData];

    }
    else{
        
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + size1.height+size7.height+size4.height+size6.height + 160);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + size1.height+size7.height+size4.height+size6.height + 130);
        }
        else
        {
           self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + size1.height+size7.height+size4.height+size6.height + 100);
        }

        
    }
    [self.commentText resignFirstResponder];
}


- (NSArray *)stageArr
{
    if (!_stageArr) {
        _stageArr = @[@"有个好主意",@"产品开发中",@"上线运营"];
//        0：有个好主意；1：产品开发中；2:上线运营
    }
    return _stageArr;
}
- (NSArray *)panterArr
{
    if (!_panterArr) {
        _panterArr = @[@"技术合伙人",@"营销合伙人",@"产品合伙人",@"运营合伙人",@"设计合伙人",@"其他合伙人"];
//        0：技术合伙人；1:营销合伙人；2：产品合伙人；3：运营合伙人；4：设计合伙人；5：其他合伙人
    }
    return _panterArr;
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
