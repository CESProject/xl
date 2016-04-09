//
//  ThreeDetailViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/4.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ThreeDetailViewController.h"
#import "UIView+MJExtension.h"
#import "common.h"
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "AchievementViewController.h"
#import "ResultsTableViewCell.h"
#import "UIBarButtonItem+Extension.h"
#import "SignUpViewController.h"
#import "CommentsTableViewCell.h"
#import "Object.h"
#import "LoadingSiteViewController.h"
#import "common.h"
@interface ThreeDetailViewController ()<UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource,WJSliderViewDelegate>
{
//    NSMutableArray *cellNumArr;
    NSMutableArray *NumArr;
    UITableView *tableview;
    // 评论
    UITableView *comTableView;
    NSMutableArray *comDateArr;
    NSMutableArray *comDateModelArr;
    int selectNum;
    
    CGSize size1;
    CGSize size2 ;
    CGSize size3 ;
    
}
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *lblCon;
//@property(nonatomic,weak)UILabel *lblDate;
//@property(nonatomic,weak)UILabel *lblDat;
@property(nonatomic,weak)UIImageView *im;

@property(nonatomic,assign)BOOL isHide;
@property(nonatomic,weak)UIScrollView *sc;
//@property(nonatomic,weak)UIImageView *imClock;

@property(nonatomic,assign)CGFloat scHeight;
@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,copy)NSString *strd;
@property (nonatomic , strong) UIButton *praiseBtn; //点赞
@property (nonatomic , strong) UILabel *praiseLab; // 点赞数
@property (nonatomic , strong) UIButton *signUpBtn; // 报名

// 路演方向
@property (nonatomic , strong) UILabel *directionTypeLab;
@property (nonatomic , strong) UILabel *directionTypeConLab;

@property (nonatomic , strong) UILabel *nameLab1;
@property (nonatomic , strong) UILabel *contentLab1;

@property (nonatomic , strong) UILabel *addressLab;
@property (nonatomic , strong) UILabel *addressConLab;

@property (nonatomic , strong) UILabel *cellphoneLab; //电话
@property (nonatomic , strong) UILabel *cellphConLab; //电话
// 手机
@property (nonatomic , strong) UILabel *mobileLab;
@property (nonatomic , strong) UILabel *mobileConLab;

@property (nonatomic , strong) UILabel *qqLab;
@property (nonatomic , strong) UILabel *qqConLab;

@property (nonatomic , strong) UILabel *wechatLab;
@property (nonatomic , strong) UILabel *wechatConLab;

@property (nonatomic , strong) UILabel *briefDescriptionLab;
@property (nonatomic , strong) UILabel *briefDescriptionConLab;
// 详细说明
@property (nonatomic , strong) UILabel *detailLab;
//@property (nonatomic , strong) UILabel *detailConLab;
@property (nonatomic , strong) UIButton *btn;

// 报名规则
@property (nonatomic , strong) UILabel *applyRuleLab;
@property (nonatomic , strong) UILabel *applyRuleConLab;

// 评论
@property (nonatomic ,strong) UIView *commentView;
@property (nonatomic , strong) UITextField *commentText;
@property (nonatomic , strong) UIButton *sendBtn;

@property (nonatomic , strong) UIView *sectionView;
@property (nonatomic , strong) UILabel *commentNum;

@property (nonatomic , strong) UIButton *prasBtn;
@property (nonatomic , strong) UILabel *prasNum;
@property (nonatomic , strong) UIButton *comSendBtn;
@property (nonatomic , strong) UILabel *comSendNum;

@property(nonatomic, strong)UICollectionView *col;
@property(nonatomic,strong)NSMutableArray *arrTransmit;

@property (nonatomic , assign) NSInteger scrollNum;
@property (nonatomic,strong)Result *res;
@property (nonatomic , strong) Result *results;
@property(nonatomic,strong)MBProgressHUD *hud;


@property (nonatomic , strong) UIView *applyLine;
@property (nonatomic , strong) UIView *detalLine;

@property (nonatomic , strong) UILabel *videoLab;
@property (nonatomic , strong) UIView *vidoView;
@property (nonatomic , strong) UIButton *videoBtn;

@end

@implementation ThreeDetailViewController
//-(NSMutableArray *)cellNumArr
//{
//    if (_cellNumArr == nil) {
//        _cellNumArr = [NSMutableArray array];
//    }
//    return _cellNumArr;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    self.currentPage = 1;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    _cellNumArr = [NSMutableArray array];
    NumArr = [NSMutableArray array];
    self.scrollNum = 0;
    
    [self initView];
    [self creatThreeView];
    [self reloadTabview];
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    comTableView.header = refreshHeader;
    [self headerRefreshing];
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    comTableView.footer = refreshFooter;
}
- (void)reloadTabview
{
    WEAKSELF;
//    [[HttpManager defaultManager] postRequestToUrl:DEF_LYCHENGGUOLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10",@"pageSize":@(10),@"pageNumber":@(1)} complete:^(BOOL successed, NSDictionary *result) {
//        //
//        if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
//        {
//            cellNumArr = [[result objectForKey:@"lists"] objectForKey:@"content"];
//            for (NSDictionary *dic in cellNumArr)
//            {
//                Result *result1 = [[Result alloc] init];
//                result1.attachmentArr = [dic objectForKey:@"attachmentList"];
//                result1.luyanContent = [dic objectForKey:@"content"];
//                result1.threeDate = [dic objectForKey:@"createDate"];
//                result1.luyanID = [dic objectForKey:@"id"];
//                result1.iconImag = [[dic objectForKey:@"createImage"] objectForKey:@"absoluteImagePath"];
//                [NumArr addObject:result1];
//                
//            }
//            [tableview reloadData];
//        }
//        
//    }];
    /**
     *   路演评论列表的接口
     */
    [self headerRefreshing];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(queue, ^{
        //获取点赞状态
        [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUDIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10"} complete:^(BOOL successed, NSDictionary *result) {
            //
            NSString *praise = result[@"obj"][@"isPraise"];
            selectNum = [praise intValue];
            if ([praise isEqualToString:@"1"]) {
                [weakSelf.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
            }
            else
            {
                [weakSelf.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
            }
        }];
    });
}
- (void)creatThreeView
{
    self.detalView= [UIView new];
    // 路演方向:
    UILabel *directionTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    directionTypeLab.text = @"路演方向:";
    directionTypeLab.font = [UIFont systemFontOfSize:14.0];
    directionTypeLab.textColor = COMColor(51, 51, 51, 1.0);
//    directionTypeLab.textAlignment = NSTextAlignmentRight;
    self.directionTypeLab = directionTypeLab;
    
    UILabel *directionTypeConLab = [[UILabel alloc]initWithFrame:CGRectMake([directionTypeLab right], 0, self.view.mj_w - directionTypeLab.mj_w -10, 30)];
    directionTypeConLab.font = [UIFont systemFontOfSize:14.0];
    directionTypeConLab.textColor = COMColor(51, 51, 51, 1.0);
    directionTypeConLab.textAlignment = NSTextAlignmentLeft;
    self.directionTypeConLab = directionTypeConLab;
    
    [self.detalView addSubview:directionTypeLab];
    [self.detalView addSubview:directionTypeConLab];
    
    // 发起地点:
    UILabel *nameLab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, directionTypeConLab.mj_h + directionTypeConLab.mj_y, 70, 30)];
    nameLab1.text = @"发起地点:";
    nameLab1.font = [UIFont systemFontOfSize:14.0];
    nameLab1.textColor = COMColor(51, 51, 51, 1.0);
//    nameLab1.textAlignment = NSTextAlignmentRight;
    self.nameLab1 = nameLab1;
    
    UILabel *contentLab1 = [[UILabel alloc]initWithFrame:CGRectMake([nameLab1 right], directionTypeConLab.mj_h + directionTypeConLab.mj_y, self.view.mj_w - nameLab1.mj_w -10, 30)];
    contentLab1.font = [UIFont systemFontOfSize:14.0];
    contentLab1.textColor = COMColor(51, 51, 51, 1.0);
    contentLab1.textAlignment = NSTextAlignmentLeft;
    self.contentLab1 = contentLab1;
    
    [self.detalView  addSubview:nameLab1];
    [self.detalView  addSubview:contentLab1];
    // 详细地址:
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLab1.mj_h + contentLab1.mj_y, 70, 30)];
    addressLab.text = @"详细地址:";
    addressLab.font = [UIFont systemFontOfSize:14.0];
    addressLab.textColor = COMColor(51, 51, 51, 1.0);
//    addressLab.textAlignment = NSTextAlignmentRight;
    self.addressLab = addressLab;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, [addressLab bottom]+5, DEF_SCREEN_WIDTH, 5)];
    lineView.backgroundColor = GRAYCOLOR;
    [self.detalView addSubview:lineView];
    
    UILabel *addressConLab = [[UILabel alloc]initWithFrame:CGRectMake([addressLab right],  contentLab1.mj_h + contentLab1.mj_y, self.view.mj_w - addressLab.mj_w -10, 30)];
    addressConLab.font = [UIFont systemFontOfSize:14.0];
    addressConLab.textColor = COMColor(51, 51, 51, 1.0);
    addressConLab.textAlignment = NSTextAlignmentLeft;
    self.addressConLab = addressConLab;
    
    [self.detalView  addSubview:addressLab];
    [self.detalView  addSubview:addressConLab];
    
    // 电话:
    UILabel *cellphoneLab = [[UILabel alloc]initWithFrame:CGRectMake(20, [lineView bottom] + 5, 70, 30)];
    cellphoneLab.text = @"电话:";
    cellphoneLab.font = [UIFont systemFontOfSize:14.0];
    cellphoneLab.textColor = COMColor(51, 51, 51, 1.0);
//    cellphoneLab.textAlignment = NSTextAlignmentRight;
    self.cellphoneLab = cellphoneLab;
    
    UILabel *cellphConLab = [[UILabel alloc]initWithFrame:CGRectMake([cellphoneLab right], addressConLab.mj_h + addressConLab.mj_y + 15, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
    cellphConLab.font = [UIFont systemFontOfSize:14.0];
    cellphConLab.textColor = COMColor(51, 51, 51, 1.0);
    cellphConLab.textAlignment = NSTextAlignmentLeft;
    self.cellphConLab = cellphConLab;
    
    [self.detalView  addSubview:cellphoneLab];
    [self.detalView  addSubview:cellphConLab];
    
    // 手机:
    UILabel *mobileLab = [[UILabel alloc]initWithFrame:CGRectMake(20, cellphConLab.mj_h + cellphConLab.mj_y , 70, 30)];
    mobileLab.text = @"手机:";
    mobileLab.font = [UIFont systemFontOfSize:14.0];
    mobileLab.textColor = COMColor(51, 51, 51, 1.0);
//    mobileLab.textAlignment = NSTextAlignmentRight;
    self.mobileLab = mobileLab;
    
    UILabel *mobileConLab = [[UILabel alloc]initWithFrame:CGRectMake([mobileLab right], cellphConLab.mj_h + cellphConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
    mobileConLab.font = [UIFont systemFontOfSize:14.0];
    mobileConLab.textColor = COMColor(51, 51, 51, 1.0);
    mobileConLab.textAlignment = NSTextAlignmentLeft;
    self.mobileConLab = mobileConLab;
    
    [self.detalView  addSubview:mobileLab];
    [self.detalView  addSubview:mobileConLab];
    // QQ:
    UILabel *qqLab = [[UILabel alloc]initWithFrame:CGRectMake(20, mobileConLab.mj_h + mobileConLab.mj_y, 70, 30)];
    qqLab.text = @"QQ:";
    qqLab.font = [UIFont systemFontOfSize:14.0];
    qqLab.textColor = COMColor(51, 51, 51, 1.0);
//    qqLab.textAlignment = NSTextAlignmentRight;
    self.qqLab = qqLab;
    
    UILabel *qqConLab = [[UILabel alloc]initWithFrame:CGRectMake([qqLab right],  mobileConLab.mj_h + mobileConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
    qqConLab.font = [UIFont systemFontOfSize:14.0];
    qqConLab.textColor = COMColor(51, 51, 51, 1.0);
    qqConLab.textAlignment = NSTextAlignmentLeft;
    self.qqConLab = qqConLab;
    
    [self.detalView  addSubview:qqLab];
    [self.detalView  addSubview:qqConLab];
    // 微信:
    UILabel *wechatLab = [[UILabel alloc]initWithFrame:CGRectMake(20, qqConLab.mj_h + qqConLab.mj_y, 70, 30)];
    wechatLab.text = @"微信:";
    wechatLab.font = [UIFont systemFontOfSize:14.0];
    wechatLab.textColor = COMColor(51, 51, 51, 1.0);
//    wechatLab.textAlignment = NSTextAlignmentRight;
    self.wechatLab = wechatLab;
    
    UILabel *wechatConLab = [[UILabel alloc]initWithFrame:CGRectMake([wechatLab right],  qqConLab.mj_h + qqConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    wechatConLab.font = [UIFont systemFontOfSize:14.0];
    wechatConLab.textColor = COMColor(51, 51, 51, 1.0);
    wechatConLab.textAlignment = NSTextAlignmentLeft;
    self.wechatConLab = wechatConLab;
    
    [self.detalView  addSubview:wechatLab];
    [self.detalView  addSubview:wechatConLab];
    
    UIView *liView = [[UIView alloc] initWithFrame:CGRectMake(0, [wechatLab bottom]+5, DEF_SCREEN_WIDTH, 5)];
    liView.backgroundColor = GRAYCOLOR;
    [self.detalView addSubview:liView];
    
    //简要说明:
    UILabel *briefDescriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(20, [liView bottom]+5, 100, 30)];
    briefDescriptionLab.text = @"简要说明:";
    briefDescriptionLab.font = [UIFont systemFontOfSize:14.0];
    briefDescriptionLab.textColor = COMColor(51, 51, 51, 1.0);
//    briefDescriptionLab.textAlignment = NSTextAlignmentRight;
    self.briefDescriptionLab = briefDescriptionLab;
    
    UIView *briefLine = [[UIView alloc]initWithFrame:CGRectMake(0, briefDescriptionLab.mj_y + briefDescriptionLab.mj_h, self.view.mj_w, 0.5)];
    briefLine.backgroundColor = [UIColor grayColor];
    
    
    UILabel *briefDescriptionConLab = [[UILabel alloc]initWithFrame:CGRectMake(20, briefDescriptionLab.mj_y + briefDescriptionLab.mj_h + 1, self.view.mj_w - 20, 30)];
    briefDescriptionConLab.font = [UIFont systemFontOfSize:14.0];
    briefDescriptionConLab.textColor = COMColor(51, 51, 51, 1.0);
    briefDescriptionConLab.textAlignment = NSTextAlignmentLeft;
    briefDescriptionConLab.numberOfLines = 0;
    self.briefDescriptionConLab = briefDescriptionConLab;
    
    [self.detalView  addSubview:briefDescriptionLab];
    [self.detalView addSubview:briefLine];
    [self.detalView  addSubview:briefDescriptionConLab];
    
    
   
    
//    UILabel *detailConLab = [[UILabel alloc]initWithFrame:CGRectMake(detailLab.mj_w, briefDescriptionConLab.mj_h + briefDescriptionConLab.mj_y, self.view.mj_w - detailLab.mj_w -10, 30)];
//    detailConLab.font = [UIFont systemFontOfSize:14.0];
//    detailConLab.textColor = COMColor(51, 51, 51, 1.0);
//    detailConLab.textAlignment = NSTextAlignmentLeft;
//    detailConLab.numberOfLines = 0;
//    self.detailConLab = detailConLab;
//    [self.detalView  addSubview:detailConLab];
    
    UILabel *applyRuleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, [briefDescriptionConLab bottom], 100, 30)];
    applyRuleLab.text = @"报名规则:";
    applyRuleLab.font = [UIFont systemFontOfSize:14.0];
    applyRuleLab.textColor = COMColor(51, 51, 51, 1.0);
//    applyRuleLab.textAlignment = NSTextAlignmentRight;
    applyRuleLab.numberOfLines = 0;
    self.applyRuleLab = applyRuleLab;
    
    UIView *applyLine = [[UIView alloc]initWithFrame:CGRectMake(0, applyRuleLab.mj_y + applyRuleLab.mj_h, self.view.mj_w, 0.5)];
    applyLine.backgroundColor = [UIColor grayColor];
    self.applyLine = applyLine;
    
    UILabel *applyRuleConLab = [[UILabel alloc]initWithFrame:CGRectMake(20,  applyRuleLab.mj_y + applyRuleLab.mj_h + 1, self.view.mj_w - 20, 30)];
    applyRuleConLab.font = [UIFont systemFontOfSize:14.0];
    applyRuleConLab.textColor = COMColor(51, 51, 51, 1.0);
    applyRuleConLab.textAlignment = NSTextAlignmentLeft;
    applyRuleConLab.numberOfLines = 0;
    self.applyRuleConLab = applyRuleConLab;
    
    [self.detalView  addSubview:applyRuleLab];
    [self.detalView addSubview:applyLine];
    [self.detalView  addSubview:applyRuleConLab];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(20, [applyRuleLab bottom], 70, 30)];
    detailLab.text = @"详细说明:";
    detailLab.font = [UIFont systemFontOfSize:14.0];
    detailLab.textColor = COMColor(51, 51, 51, 1.0);
//    detailLab.textAlignment = NSTextAlignmentRight;
    self.detailLab = detailLab;
    
    UIView *detalLine = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.mj_y + detailLab.mj_h, self.view.mj_w, 0.5)];
    detalLine.backgroundColor = [UIColor grayColor];
    self.detalLine = detalLine;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake([detailLab right],detailLab.mj_y,100, detailLab.mj_h);
    [btn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn setTitle:@"点击查看详情" forState:0];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.detalView  addSubview:detailLab];
    [self.detalView addSubview:detalLine];
    [self.detalView addSubview:btn];
    self.btn = btn;
    
    UILabel *videoLab = [[UILabel alloc] initWithFrame:CGRectMake(detailLab.mj_x, [self.btn bottom]+100, detailLab.mj_w, detailLab.mj_h)];
    videoLab.text =@"视频:";
    videoLab.font = [UIFont systemFontOfSize:14.0];
    self.videoLab = videoLab;
    [self.detalView addSubview:videoLab];
    
    UIView *vidoView = [[UIView alloc] initWithFrame:CGRectMake([videoLab right], videoLab.mj_y, DEF_SCREEN_WIDTH/2, DEF_SCREEN_WIDTH/2*3/4)];
    vidoView.backgroundColor = [UIColor lightGrayColor];
    self.vidoView = vidoView;
    [self.detalView addSubview:vidoView];
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.center = CGPointMake(vidoView.mj_w/2, vidoView.mj_h/2);
    videoBtn.bounds = CGRectMake(0, 0, vidoView.mj_h/3, vidoView.mj_h/3);
    [videoBtn setBackgroundImage:[UIImage imageNamed:@"c-1"] forState:0];
    [videoBtn addTarget:self action:@selector(openVideo) forControlEvents:UIControlEventTouchUpInside];
    [vidoView addSubview:videoBtn];
    self.videoBtn = videoBtn;
    
    self.commentsView = [UIView new];
    self.commentsView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 50 )];
    commentView.backgroundColor = [UIColor whiteColor];
    
    
    
    UITextField *commentText = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width  - 100, 30)];
    //    commentText.backgroundColor = [UIColor grayColor];
    commentText.placeholder = @"请输入评论的内容";
    commentText.borderStyle = UITextBorderStyleRoundedRect;
    commentText.delegate = self;
    self.commentText = commentText;
    [commentView addSubview:commentText];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake([commentText right]+10, self.commentText.mj_y, 60, 30);
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 4;
    sendBtn.layer.borderWidth = 1;
    sendBtn.tintColor = GREENCOLOR;
    sendBtn.layer.borderColor = GREENCOLOR.CGColor;
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn addTarget:self action:@selector(sendComBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn = sendBtn;
    [commentView addSubview:sendBtn];
    
    self.commentView = commentView;
    [self.commentsView  addSubview:commentView];
    
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.commentView.mj_y + self.commentView.mj_h + 5, self.view.mj_w, 30)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *commentNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 30)];
    commentNum.text = @"全部评论";
    commentNum.font = [UIFont systemFontOfSize:14.0f];
    self.commentNum = commentNum;
    [sectionView addSubview:commentNum];
//    // 点赞
//    UIButton *prasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [prasBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
//    prasBtn.frame = CGRectMake(self.view.mj_w - 200, 13, 25, 25);
//    self.prasBtn = prasBtn;
//    
//    UILabel *prasNum = [[UILabel alloc]initWithFrame:CGRectMake(self.prasBtn.mj_x + self.prasBtn.mj_w, 5, 70, 40)];
//    
//    self.prasNum = prasNum;
    // 评论
    UIButton *comSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comSendBtn.frame = CGRectMake(DEF_SCREEN_WIDTH-70, 0, 30, 30);
    [comSendBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
    self.comSendBtn = comSendBtn;
    UILabel *comSendNum = [[UILabel alloc]initWithFrame:CGRectMake( self.comSendBtn.mj_w + self.comSendBtn.mj_x, 0, self.view.mj_w - self.comSendBtn.mj_w - self.comSendBtn.mj_x - 10, 30)];
    comSendNum.font = [UIFont systemFontOfSize:12];
    self.comSendNum = comSendNum;
    
//    [sectionView addSubview:prasBtn];
//    [sectionView addSubview:prasNum];
    [sectionView addSubview:comSendBtn];
    [sectionView addSubview:comSendNum];
    self.sectionView = sectionView;
    [self.commentsView  addSubview:sectionView];
    
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 1, self.view.mj_w, self.view.bounds.size.height /2) style:UITableViewStylePlain];
    comTableView.backgroundColor = [UIColor whiteColor]; //DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [comTableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [self.commentsView addSubview:comTableView];
    
    
//    self.resulsView = [UIView new];
//    tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    tableview.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
//    tableview.dataSource = self;
//    tableview.delegate  = self;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.resulsView addSubview:tableview];
//    
//    [tableview registerClass:[ResultsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
//    UILabel *label3 = [UILabel new];
    
    label1.text = @"详情";
    label2.text = @"评论";
//    label3.text = @"成果";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
//    label3.textAlignment = NSTextAlignmentCenter;
    
    if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
    { //新增判断4s
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + 300) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
   else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height ) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else
    {
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
    self.wjScroll.delegate = self;
    [self.sc addSubview:self.wjScroll];
    }
    NSLog(@"%@",[common getCurrentDeviceModel:self]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
    
    self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height);
}
- (void)openVideo
{
//    LoadingSiteViewController *loadVC = [[LoadingSiteViewController alloc] init];
//    loadVC.conUrl = [NSString stringWithFormat:@"%@?roadshowId=%@",DEF_LYSHIPIN,self.listFriend.roadId];
//    [self.navigationController pushViewController:loadVC animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?videoId=%@",DEF_LYSHIPIN,self.listFriend.videoId]]];
//    NSLog(@"======>%@",[NSString stringWithFormat:@"%@?videoId=%@",DEF_LYSHIPIN,self.listFriend.videoId]);
}
- (void)detailClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.res.detail;
    [self.navigationController pushViewController:achVC animated:YES];
}
- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    [self.commentText resignFirstResponder];
    self.scrollNum = index;
    if (self.scrollNum == 1)
    {
//        if (self.results.content.count <= 10){
//            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 145);
//        }else {
//             self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y -20);       }
        
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 145);
        }
        else
        {
            
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 160);
        }
        [comTableView reloadData];
    }
//    else if(self.scrollNum == 2)   {   [tableview reloadData]; }
    else
    {
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height+DEF_SCREEN_WIDTH/2*3/4 + 20);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height+DEF_SCREEN_WIDTH/2*3/4);
        }
        else
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height+DEF_SCREEN_WIDTH/2*3/4 - 40);
        }

       
    }
}

- (void)keyboardShow:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    if (ff.height < self.scHeight + keyboardH) {
        ff.height += keyboardH;
        self.sc.contentSize = ff;
        //        CGPoint position = CGPointMake(0, keyboardH);
        //        [self.sc setContentOffset:position animated:YES];
    }
    
}
- (void)keyboardHide:(NSNotification *)not
{
    
    NSDictionary *dict = not.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardFrame.size.height;
    CGSize ff = self.sc.contentSize;
    ff.height -= keyboardH;
    self.sc.contentSize = ff;
    
}

- (void)initView
{
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"路演详情";
    self.navigationController.navigationBarHidden = NO;
    
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)"];
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h-64)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [common createLabelWithFrame:CGRectZero andText:self.strTitle];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont systemFontOfSize:18.0f];
    [sc addSubview:titleLab];
    self.titleLab = titleLab;
    
//    UIImageView *imclock = [[UIImageView alloc] init];
//    imclock.image = [UIImage imageNamed:@"clock"];
//    [sc addSubview:imclock];
//    self.imClock = imclock;
//    
//    UILabel *lblDat = [common createLabelWithFrame:CGRectZero andText:self.strd];
//    lblDat.font = [UIFont systemFontOfSize:14.0f];
//    lblDat.textColor = [UIColor grayColor];
//    lblDat.text = @"开始时间:";
//    [sc addSubview:lblDat];
//    self.lblDat = lblDat;
//    
//    UILabel *lblDate = [common createLabelWithFrame:CGRectZero andText:self.strd];
//    lblDat.textColor =[UIColor grayColor];
//    lblDate.font = [UIFont systemFontOfSize:14.0f];
//    [sc addSubview:lblDate];
//    self.lblDate = lblDate;
    
    UIImageView *im = [[UIImageView alloc] init];
    im.layer.masksToBounds = YES;
    //    im.layer.cornerRadius = 4;
    [sc addSubview:im];
    self.im = im;
    im.hidden = self.isHide;
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [praiseBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    praiseBtn.layer.masksToBounds = YES;
    praiseBtn.layer.cornerRadius = 4;
    self.praiseBtn = praiseBtn;
    [sc addSubview:praiseBtn];
    
        UILabel *praiseLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
        praiseLab.font = [UIFont systemFontOfSize:14.0f];
        [sc addSubview:praiseLab];
        self.praiseLab = praiseLab;
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [signUpBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(signUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.layer.masksToBounds = YES;
    signUpBtn.layer.cornerRadius = 4;
    signUpBtn.layer.borderWidth = 1;
    signUpBtn.hidden = YES; // 路演报名被取消
    signUpBtn.tintColor = GREENCOLOR;
    signUpBtn.layer.borderColor = GREENCOLOR.CGColor;
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.signUpBtn = signUpBtn;
    [sc addSubview:signUpBtn];
    
    
    
    self.sc = sc;
    [self.view addSubview:sc];
    [self initData];
}

- (void)initData
{
    
    CGSize sizeTitle = [common sizeWithString:@"" font:[UIFont systemFontOfSize:20.0f] maxSize:CGSizeMake(self.view.mj_w - 40, 0)];
    
    self.titleLab.frame = CGRectMake(10, 5, self.view.mj_w - 20, sizeTitle.height);
//    self.imClock .frame = CGRectMake(10,  self.titleLab.mj_h + self.titleLab.mj_y + 18, 15, 15);
    
//    self.lblDat.frame = CGRectMake(self.imClock.mj_w + self.imClock.mj_x + 10,self.titleLab.mj_h + self.titleLab.mj_y + 16, 70, 20);
//    self.lblDate.frame = CGRectMake(self.lblDat.mj_w + self.lblDat.mj_x ,self.titleLab.mj_y+ self.titleLab.mj_h + 15, 140, 20);
    self.im.frame = CGRectMake(10, self.titleLab.mj_y + self.titleLab.mj_h + 20, self.view.mj_w - 20 , (self.view.mj_w - 20)/ 5 * 3);
    
    self.praiseBtn.frame = CGRectMake(10, self.im.mj_y + self.im.mj_h + 20, 25 , 25);
    self.praiseLab.frame = CGRectMake(self.praiseBtn.mj_w + self.praiseBtn.mj_x , self.im.mj_y + self.im.mj_h + 20, self.view.mj_w / 2 , 25);
    self.signUpBtn.frame = CGRectMake(self.view.mj_w - 80 , self.im.mj_y + self.im.mj_h + 20, 70, 25);
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 10, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.sc addSubview:grayView];
    
    self.praiseLab.backgroundColor = [UIColor whiteColor];
    self.praiseBtn.backgroundColor = [UIColor whiteColor];
    self.titleLab.backgroundColor = [UIColor whiteColor];
//    self.lblDate.backgroundColor = [UIColor whiteColor];
    self.im.backgroundColor = [UIColor whiteColor];
    self.lblCon.backgroundColor = [UIColor whiteColor];
    
   self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height);
    
}

-(void)setListFriend:(ListFriend *)listFriend
{
    self.hud = [common createHud];
    _listFriend = listFriend;
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LYDETAIL params:@{@"id":self.listFriend.roadId } complete:^(BOOL successed, NSDictionary *result) {
        //
        if ([result isKindOfClass:[NSDictionary class]])
        {
            NSLog(@" HttpManager %@",result);
            NSDictionary *dic = result[@"obj"];
            Result *result1 = [[Result alloc] init];
            result1.luyanID = [common checkStrValue:dic[@"id"]];
            result1.categoryId = [common checkStrValue:dic[@"categoryId"]];
            result1.name = [common checkStrValue:dic[@"name"]];
            result1.directionType = [common checkStrValue:dic[@"directionType"]].intValue;
            result1.type = [common checkStrValue:dic[@"type"]];
            if([dic[@"image"] isKindOfClass:[NSDictionary class]])
            {
                result1.iconImag = [common checkStrValue:dic[@"image"][@"absoluteImagePath"]];
            }
            result1.briefDescription = [common checkStrValue:dic[@"briefDescription"]];
            NSString *str1 = [NSString stringWithFormat:@"%@",[common checkStrValue:dic[@"createDate"]]];
            result1.createDate =  [common sectionStrByCreateTime:str1.doubleValue ];
            result1.praiseCount =[NSString stringWithFormat:@"%@", [common checkStrValue:dic[@"praiseCount"]]]; // 待测
            result1.cellphone = [common checkStrValue:[dic objectForKey:@"cellphone"]];
            result1.mobile               = [common checkStrValue:dic[@"mobile"]];
            result1.qq                   = [common checkStrValue:dic[@"qq"]];
            result1.wechat               = [common checkStrValue:dic[@"wechat"]];
            result1.directionType        = [common checkStrValue:dic[@"directionType"]].intValue;
            result1.address              = [common checkStrValue:dic[@"address"]];
            result1.briefDescription     = [common checkStrValue:dic[@"briefDescription"]];
            result1.detail               = [common checkStrValue:dic[@"detail"]];
            result1.applyRule            = [common checkStrValue:dic[@"applyRule"]];
            result1.typeName             = [common checkStrValue:dic[@"typeName"]];
            result1.commentNum           = [common checkStrValue:[NSString stringWithFormat:@"%@", dic[@"commentNum"]]];
            weakSelf.res = result1;
            [weakSelf loadResult:result1];
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
//    _cellNumArr = [NSMutableArray array];
    
    [[HttpManager defaultManager]postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10",@"pageSize":@(10),@"pageNumber":@(self.currentPage),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
           if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
           {
               [comTableView.header endRefreshing];
               Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
               weakSelf.results = resul;
               weakSelf.totalPage = resul.totalPages;
               self.comSendNum.text = resul.totalElements;
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
    [[HttpManager defaultManager]postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10",@"pageSize":@(10),@"pageNumber":@(self.currentPage),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [comTableView.header endRefreshing];
                Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
                weakSelf.results = resul;
                weakSelf.totalPage = resul.totalPages;
                self.comSendNum.text = resul.totalElements;
                [_cellNumArr addObjectsFromArray:resul.content];
                [comTableView reloadData];
                [comTableView.footer endRefreshing];
            }
        }
        [comTableView.footer endRefreshing];
    }];
}
- (void)loadResult:(Result *)resultVo
{
    self.titleLab.text              = resultVo.name;
//    self.lblDate.text               = resultVo.createDate;
    self.praiseLab.text             = resultVo.praiseCount;
    self.cellphConLab.text          = resultVo.cellphone;
    self.mobileConLab.text          = resultVo.mobile;
    self.qqConLab.text              = resultVo.qq;
    self.wechatConLab.text          = resultVo.wechat;
    
    
    self.addressConLab.text         = resultVo.address;
    
    self.directionTypeConLab.text   = resultVo.typeName;
//    CGSize size1 ;
    if (!resultVo.briefDescription || [resultVo.briefDescription isEqualToString:@""]) {
        size1 = CGSizeMake(self.view.mj_w - self.briefDescriptionLab.mj_w -10, 30);
        self.briefDescriptionConLab.frame = CGRectMake(20, self.briefDescriptionLab.mj_y + self.briefDescriptionLab.mj_h + 1, self.view.mj_w - 20, 30);
    }
    else
    {
        size1 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.briefDescriptionLab.mj_w -10, resultVo.briefDescription, 14.0);
        if (size1.height < 30) {
            size1.height = 30;
        }
        self.briefDescriptionConLab.frame =CGRectMake(20, self.briefDescriptionLab.mj_y + self.briefDescriptionLab.mj_h + 1, self.view.mj_w - 20, size1.height);
        
    }
    self.briefDescriptionConLab.text= resultVo.briefDescription;
    UIView *liView1 = [[UIView alloc] initWithFrame:CGRectMake(0, [self.briefDescriptionConLab bottom]+5, DEF_SCREEN_WIDTH, 5)];
    liView1.backgroundColor = GRAYCOLOR;
    [self.detalView addSubview:liView1];
    
    
//    self.detailLab.frame = CGRectMake(20, [self.applyRuleLab bottom], 100, 30);
    
//    CGSize size2 ;
    if (!resultVo.detail || [resultVo.detail isEqualToString:@""]) {
        size2 = CGSizeMake(self.view.mj_w - self.detailLab.mj_w -10, 30);
//       self.detailConLab.frame = CGRectMake(self.detailLab.mj_w, self.detailLab.mj_y, self.view.mj_w - self.detailLab.mj_w -10, size2.height);
//        self.detailConLab.text          = resultVo.detail;
    }
    else
    {
        size2 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.detailLab.mj_w -10, resultVo.detail, 14.0);
        if (size2.height < 30) {
            size2.height = 30;
        }
        size2 = CGSizeMake(self.view.mj_w - self.detailLab.mj_w -10, 30);
//        self.detailConLab.frame = CGRectMake(self.detailLab.mj_w, self.detailLab.mj_y, self.view.mj_w - self.detailLab.mj_w -10, size2.height);
//        self.detailConLab.text          = resultVo.detail;
    }
    
   
    
    self.applyRuleLab.frame = CGRectMake(20, [self.briefDescriptionConLab bottom] + 20, 100, 30);
    
    self.applyLine.frame = CGRectMake(0, self.applyRuleLab.mj_y + self.applyRuleLab.mj_h, self.view.mj_w, 0.5);
//    CGSize size3 ;
    if (!resultVo.applyRule || [resultVo.applyRule isEqualToString:@""]) {
        size3 = CGSizeMake(self.view.mj_w - 20, 30);
        
       
        self.applyRuleConLab.frame =  CGRectMake(20,  self.applyRuleLab.mj_y + self.applyRuleLab.mj_h + 1, self.view.mj_w - 20, size3.height);
        self.applyRuleConLab.text       = resultVo.applyRule;
    }
    else
    {
        size3 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - self.detailLab.mj_w -10, resultVo.applyRule, 14.0);
        if (size3.height < 30) {
            size3.height = 30;
        }
        self.applyRuleConLab.frame = CGRectMake(20,  self.applyRuleLab.mj_y + self.applyRuleLab.mj_h + 1, self.view.mj_w - 20, size3.height);
        self.applyRuleConLab.text       = resultVo.applyRule;
    }
    
    
    UIView *liView2 = [[UIView alloc] initWithFrame:CGRectMake(0, [self.applyRuleConLab bottom]+5, DEF_SCREEN_WIDTH, 5)];
    liView2.backgroundColor = GRAYCOLOR;
    [self.detalView addSubview:liView2];
    
    self.detailLab.frame = CGRectMake(20, self.applyRuleConLab.mj_y + self.applyRuleConLab.mj_h + 20, 70, 30);
    
    
   self.detalLine.frame = CGRectMake(0, self.detailLab.mj_y + self.detailLab.mj_h, self.view.mj_w, 0.5);
    
    self.btn.frame =CGRectMake([self.detailLab right],self.detailLab.mj_y,100, self.detailLab.mj_h);
    
    
    self.prasNum.text               = resultVo.praiseCount;
    if ([resultVo.commentNum isEqualToString:@"<null>"]) {
        self.comSendNum.text = @"";
    }
    else
    {
        self.comSendNum.text            = resultVo.totalElements;
    }
    [self.im sd_setImageWithURL:[NSURL URLWithString:resultVo.iconImag] placeholderImage:[UIImage imageNamed:@"picf"]];
    
    
    self.videoLab.frame = CGRectMake(self.detailLab.mj_x, [self.btn bottom]+20, self.detailLab.mj_w, self.detailLab.mj_h);
    self.vidoView.frame = CGRectMake([self.videoLab right], self.videoLab.mj_y, DEF_SCREEN_WIDTH/2, DEF_SCREEN_WIDTH/2*3/4);
    self.videoBtn.bounds = CGRectMake(0, 0, self.vidoView.mj_h/3, self.vidoView.mj_h/3);
 
    self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100 + size1.height + size2.height + size3.height+DEF_SCREEN_WIDTH/2*3/4);
}
/**
 *   加载路演评论列表
 */
//- (void)loadCommentList
//{
//    
//    WEAKSELF;
//    comDateModelArr = [NSMutableArray array];
//    
//    [[HttpManager defaultManager]postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10",@"pageSize":@(10),@"pageNumber":@(1),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
//        
//        NSLog(@"%@",result);
//        Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
//        NSLog(@"%@",resul.content);
//        weakSelf.results = resul;
//        
//        [comTableView reloadData];
//        //
//    }];
//    
//}
#pragma mark - Button Select Action
- (void)sendComBtnAction
{
    self.sendBtn.enabled = NO;
    if ([self.commentText.text isEqualToString:@""]) {
        showAlertView(@"评论内容不能为空");
        self.sendBtn.enabled = YES;
        return ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_SENDCOMMENT params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10",@"content":self.commentText.text} complete:^(BOOL successed, NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            //
            if ([result[@"code"] isEqualToString:@"10000"]) {
                [weakSelf headerRefreshing];
                weakSelf.commentText.text = @"";
            }
            else
            {
                showAlertView(@"评论发表失败");
            }
        }
        else
        {
            showAlertView(@"评论发表失败");
        }
        
        NSLog(@"%@",result);
        self.sendBtn.enabled = YES;
    }];
}

- (void)praiseBtnAction:(UIButton *)sender
{
    
    if (selectNum%2==1) {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_DIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10"} complete:^(BOOL successed, NSDictionary *result) {
            //
            if (successed) {
                if ([result[@"code"] isEqualToString:@"10000"])
                {
                    [MBProgressHUD showSuccess:@"点赞成功" toView:weakSelf.view];
                                        weakSelf.praiseLab.text = [NSString stringWithFormat:@"%d",[weakSelf.praiseLab.text intValue]+1];
                    
                }
            }else
            {
            }
        }];
    }
    else
    {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_QUXIAODIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"10"} complete:^(BOOL successed, NSDictionary *result) {
            //
            if ([result[@"code"] isEqualToString:@"10000"])
            {
                [MBProgressHUD showSuccess:@"已取消点赞" toView:weakSelf.view];
                                weakSelf.praiseLab.text = [NSString stringWithFormat:@"%d",[weakSelf.praiseLab.text intValue]-1];
            }
        }];
    }
    selectNum ++;
}

- (void)signUpBtnAction:(UIButton *)sender
{
    SignUpViewController *signUpVC = [[SignUpViewController alloc]init];
    signUpVC.roadShowId = self.listFriend.roadId;
    [self.navigationController pushViewController:signUpVC animated:YES];
}

//- (void)keyboardShow:(NSNotification *)not
//{
//    
//    NSDictionary *dict = not.userInfo;
//    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyboardH = keyboardFrame.size.height;
//    CGSize ff = self.sc.contentSize;
//    //    if (ff.height < self.scHeight + keyboardH) {
//    ff.height += keyboardH;
//    self.sc.contentSize = ff;
//    //    }
//    
//    
//    
//}
//- (void)keyboardHide:(NSNotification *)not
//{
//    
//    NSDictionary *dict = not.userInfo;
//    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyboardH = keyboardFrame.size.height;
//    CGSize ff = self.sc.contentSize;
//    ff.height -= keyboardH;
//    self.sc.contentSize = ff;
//    
//}

#pragma mark - textField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.scrollNum == 1)
    {
        //        return comDateModelArr.count;
        return _cellNumArr.count;
    }
//    else  if (self.scrollNum == 2)
//    {
//        return cellNumArr.count;
//    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 1){
        
        CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
        ListFriend *objc = [_cellNumArr objectAtIndex:indexPath.row];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:objc.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        cell.nameLab.text = objc.userName;
        cell.dateLab.text = [common compareCurrentTime:objc.createDate];
        cell.contLab.text = objc.content;
        return cell;
    }
//    else if (self.scrollNum == 2)
//    {
//        ResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        Result *re = [NumArr objectAtIndex:indexPath.row];
//        cell.detailLab.text = re.luyanContent;
//        cell.dateLab.text = [common sectionStrByCreateTime:re.threeDate.doubleValue];
//        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:re.iconImag] placeholderImage:nil];
//        return cell;
//    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 1)
    {
        
        return 60;
    }
    else
    {
        
        return 150;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 1){
        
        
    }
//    else if (self.scrollNum == 2)
//    {
//        Result *re = [NumArr objectAtIndex:indexPath.row];
//        AchievementViewController *achVC = [[AchievementViewController alloc] init];
//        achVC.titl = @"成果";
//        achVC.contentStr = re.luyanContent;
//        [self.navigationController pushViewController:achVC animated:YES];
//    }
//    else
//    {
//        
//    }
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
