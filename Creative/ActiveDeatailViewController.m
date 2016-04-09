//
//  ActiveDeatailViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ActiveDeatailViewController.h"
#import "UIView+MJExtension.h"
#import "common.h"
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "AchievementViewController.h"
#import "ResultsTableViewCell.h"
#import "UIBarButtonItem+Extension.h"
#import "CommentsTableViewCell.h"
#import "ActiveSignViewController.h"
#import "Object.h"
#import "NSDate+Utilities.h"
#import "LoadingSiteViewController.h"
#import "MJRefresh.h"

@interface ActiveDeatailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WJSliderViewDelegate>
{
    NSMutableArray *NumArr;
    UITableView *tableview;
    // 评论
    UITableView *comTableView;
    NSMutableArray *comDateArr;
    
    int selectNum;
    
}
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *lblCon;
@property(nonatomic,weak)UILabel *lblDate;
@property(nonatomic,weak)UILabel *lblDat;
@property(nonatomic,weak)UIImageView *im;

@property(nonatomic,assign)BOOL isHide;
@property(nonatomic,weak)UIScrollView *sc;
@property(nonatomic,weak)UIImageView *imClock;


@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,copy)NSString *strd;
@property (nonatomic , strong) UIButton *praiseBtn; //点赞
@property (nonatomic , strong) UILabel *praiseLab; // 点赞数
@property (nonatomic , strong) UIButton *signUpBtn; // 报名


@property (nonatomic , strong) UIImageView *clockIm;
@property (nonatomic , strong) UILabel *clockImLab;

@property (nonatomic , strong) UILabel *cellphoneLab; //电话
@property (nonatomic , strong) UILabel *cellphConLab; //电话
// 手机
@property (nonatomic , strong) UILabel *mobileLab;
@property (nonatomic , strong) UILabel *mobileConLab;

@property (nonatomic , strong) UILabel *qqLab;
@property (nonatomic , strong) UILabel *qqConLab;

@property (nonatomic , strong) UILabel *wechatLab;
@property (nonatomic , strong) UILabel *wechatConLab;

//// 详细说明
@property (nonatomic , strong) UILabel *detailLab;
@property (nonatomic , strong) UILabel *detailConLab;

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
@property (nonatomic , strong) UIButton *endBtn;

@property(nonatomic, strong)UICollectionView *col;
@property(nonatomic,strong)NSMutableArray *arrTransmit;

@property (nonatomic , assign) NSInteger scrollNum;

@property (nonatomic,strong)Object *objec;
@property (nonatomic , strong) Result *results;
@property(nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic , strong) UIView *detalLine;
@end

@implementation ActiveDeatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
//    self.title = self.listFriend.theme;
    self.title = @"活动详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];

    self.scrollNum = 0;
    self.currentPage = 1;
    _cellNumArr = [NSMutableArray array];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    [self reloadChengguoTabview];
}
- (void)setListFriend:(ListFriend *)listFriend
{
    self.hud = [common createHud];
    _listFriend = listFriend;
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ACTIVEDETAIL params:@{@"id":self.listFriend.roadId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Object *obj = [Object objectWithKeyValues:result[@"obj"]];
                weakSelf.objec = obj;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
                dispatch_async(queue, ^{
                    //获取点赞状态
                    [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUDIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8"} complete:^(BOOL successed, NSDictionary *result) {
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
                [self creatThreeView];
                MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
                comTableView.header = refreshHeader;
                
                MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
                comTableView.footer = refreshFooter;
                
                if (obj.isEnroll==0)
                {
                    self.endBtn.hidden = NO;
                    [self.endBtn setTitle:@"活动已报名" forState:0];
                    self.signUpBtn.hidden = YES;
                }else
                {
                    static NSDateFormatter *formatter = nil;
                    if (nil == formatter) {
                        formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    }
                    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:(listFriend.deadline / 1000)];
                    if ([dat isEarlierThanDate:[NSDate date]]==YES)
                    {
                        self.endBtn.hidden = NO;
                        [self.endBtn setTitle:@"活动已结束" forState:0];
                        self.signUpBtn.hidden = YES;
                    }else
                    {
                        if ([obj.currentNum isEqualToString:obj.upperLimit]) {
                            self.endBtn.hidden = NO;
                            [self.endBtn setTitle:@"人数已满" forState:0];
                            self.signUpBtn.hidden = YES;
                        }else
                        {
                            self.endBtn.hidden = YES;
                            self.signUpBtn.hidden = NO;
                        }
                    }
                }
            }

        }
        [weakSelf.hud hide:YES];
    }];
    
    /**
     * 活动评论列表
     */
//    [self headerRefreshing];
}
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [comTableView.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8",@"pageSize":@(10),@"pageNumber":@(self.currentPage),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8",@"pageSize":@(10),@"pageNumber":@(self.currentPage),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
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
//- (void)loadCommentList
//{
//    /**
//     * 活动评论列表
//     */
//    WEAKSELF;
//    [[HttpManager defaultManager] postRequestToUrl:DEF_LYCOMMENTLIEBIAO params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8",@"pageSize":@(10),@"pageNumber":@(1),@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
//        if (successed)
//        {
//            Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
//            weakSelf.results = resul;
//            [comTableView reloadData];
//            
//        }
//    }];
//    
//}
- (void)creatThreeView
{
    self.detalView= [UIView new];
    UIImageView *clockIm = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    clockIm.image = [UIImage imageNamed:@"clock"];
    self.clockIm = clockIm;
    [self.detalView addSubview:clockIm];
    
    
    UILabel *clockImLab = [[UILabel alloc]initWithFrame:CGRectMake([clockIm right]+10, 5, self.view.mj_w - clockIm.mj_w -10, 30)];
    clockImLab.font = [UIFont systemFontOfSize:14.0];
    clockImLab.textColor = COMColor(51, 51, 51, 1.0);
    clockImLab.textAlignment = NSTextAlignmentLeft;
    clockImLab.text = [common sectionStrByCreateTime:self.objec.endDate];
    self.clockImLab = clockImLab;
    [self.detalView addSubview:clockImLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(clockImLab.mj_x, clockImLab.mj_y + clockImLab.mj_h, DEF_SCREEN_WIDTH - clockImLab.mj_x -20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.detalView addSubview:line];
    
    UIImageView *AddressIm = [[UIImageView alloc]initWithFrame:CGRectMake(clockIm.mj_x, [line bottom]+10, 15, 15)];
    AddressIm.image = [UIImage imageNamed:@"needle"];
//    self.AddressIm = AddressIm;
    
    UILabel *AddressImLab = [[UILabel alloc]initWithFrame:CGRectMake(clockImLab.mj_x, AddressIm.mj_y - 4, self.view.mj_w - AddressIm.mj_w -20, 30)];
    AddressImLab.font = [UIFont systemFontOfSize:14.0];
    AddressImLab.textColor = COMColor(51, 51, 51, 1.0);
    AddressImLab.textAlignment = NSTextAlignmentLeft;
    AddressImLab.text = self.objec.address;
//    self.AddressImLab = AddressImLab;
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(line.mj_x, AddressImLab.mj_y + AddressImLab.mj_h, line.mj_w, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    [self.detalView addSubview:AddressIm];
    [self.detalView addSubview:line1];
    [self.detalView addSubview:AddressImLab];
    
    UIImageView *perIm = [[UIImageView alloc]initWithFrame:CGRectMake(10, AddressImLab.mj_h + AddressImLab.mj_y + 16, 15, 15)];
    perIm.image = [UIImage imageNamed:@"per"];
    //    self.AddressIm = AddressIm;
    
    UILabel *perImLab = [[UILabel alloc]initWithFrame:CGRectMake(clockImLab.mj_x, AddressImLab.mj_h + AddressImLab.mj_y + 10, self.view.mj_w - AddressIm.mj_w -10, 30)];
    perImLab.font = [UIFont systemFontOfSize:14.0];
    perImLab.textColor = COMColor(51, 51, 51, 1.0);
    perImLab.textAlignment = NSTextAlignmentLeft;
    if ([self.objec.currentNum isEqualToString:@"<null>"] || !self.objec.currentNum)
    {
        perImLab.text = [NSString stringWithFormat:@"0/%@人",self.objec.upperLimit];
    }
    else
    {
        
        perImLab.text = [NSString stringWithFormat:@"%@/%@人",self.objec.currentNum,self.objec.upperLimit];
    }
    //    self.AddressImLab = AddressImLab;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(line.mj_x, perImLab.mj_y + perImLab.mj_h, line.mj_w, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    
    [self.detalView addSubview:perIm];
    [self.detalView addSubview:line2];
    [self.detalView addSubview:perImLab];
    
    
    UIImageView *dollIm = [[UIImageView alloc]initWithFrame:CGRectMake(10, perImLab.mj_h + perImLab.mj_y + 11, 15, 15)];
    dollIm.image = [UIImage imageNamed:@"doll"];
    //    self.AddressIm = AddressIm;
    
    UILabel *dollImLab = [[UILabel alloc]initWithFrame:CGRectMake(clockImLab.mj_x, perImLab.mj_h + perImLab.mj_y + 1, self.view.mj_w - dollIm.mj_w -10, 30)];
    dollImLab.font = [UIFont systemFontOfSize:14.0];
    dollImLab.textColor = COMColor(51, 51, 51, 1.0);
    dollImLab.textAlignment = NSTextAlignmentLeft;
    dollImLab.text = self.objec.cost;
    //    self.AddressImLab = AddressImLab;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, dollImLab.mj_y + dollImLab.mj_h + 10, self.view.mj_w , 5)];
    line3.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self.detalView addSubview:dollIm];
    [self.detalView addSubview:line3];
    [self.detalView addSubview:dollImLab];

    
    // 电话:
    UILabel *cellphoneLab = [[UILabel alloc]initWithFrame:CGRectMake(10, dollImLab.mj_h + dollImLab.mj_y + 15, 70, 30)];
    cellphoneLab.text = @"联系人:";
    cellphoneLab.font = [UIFont systemFontOfSize:14.0];
    cellphoneLab.textColor = COMColor(51, 51, 51, 1.0);
//    cellphoneLab.textAlignment = NSTextAlignmentRight;
    self.cellphoneLab = cellphoneLab;
    
    UILabel *cellphConLab = [[UILabel alloc]initWithFrame:CGRectMake(cellphoneLab.frame.size.width, dollImLab.mj_h + dollImLab.mj_y + 15, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    cellphConLab.font = [UIFont systemFontOfSize:14.0];
    cellphConLab.textColor = COMColor(51, 51, 51, 1.0);
    cellphConLab.textAlignment = NSTextAlignmentLeft;
    cellphConLab.text = self.objec.linkman;
    self.cellphConLab = cellphConLab;
    
    [self.detalView  addSubview:cellphoneLab];
    [self.detalView  addSubview:cellphConLab];
    
    // 手机:
    UILabel *mobileLab = [[UILabel alloc]initWithFrame:CGRectMake(10, cellphConLab.mj_h + cellphConLab.mj_y , 70, 30)];
    mobileLab.text = @"手机:";
    mobileLab.font = [UIFont systemFontOfSize:14.0];
    mobileLab.textColor = COMColor(51, 51, 51, 1.0);
//    mobileLab.textAlignment = NSTextAlignmentRight;
    self.mobileLab = mobileLab;
    
    UILabel *mobileConLab = [[UILabel alloc]initWithFrame:CGRectMake(mobileLab.mj_w, cellphConLab.mj_h + cellphConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
    
    mobileConLab.font = [UIFont systemFontOfSize:14.0];
    mobileConLab.textColor = COMColor(51, 51, 51, 1.0);
    mobileConLab.textAlignment = NSTextAlignmentLeft;
    mobileConLab.text = self.objec.cellphone;
    self.mobileConLab = mobileConLab;
    
    [self.detalView  addSubview:mobileLab];
    [self.detalView  addSubview:mobileConLab];
    // QQ:
    UILabel *qqLab = [[UILabel alloc]initWithFrame:CGRectMake(10, mobileConLab.mj_h + mobileConLab.mj_y, 70, 30)];
    qqLab.text = @"QQ:";
    qqLab.font = [UIFont systemFontOfSize:14.0];
    qqLab.textColor = COMColor(51, 51, 51, 1.0);
//    qqLab.textAlignment = NSTextAlignmentRight;
    self.qqLab = qqLab;
    
    UILabel *qqConLab = [[UILabel alloc]initWithFrame:CGRectMake(qqLab.mj_w,  mobileConLab.mj_h + mobileConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];
  
    qqConLab.font = [UIFont systemFontOfSize:14.0];
    qqConLab.textColor = COMColor(51, 51, 51, 1.0);
    qqConLab.textAlignment = NSTextAlignmentLeft;
    qqConLab.text = self.objec.qq;
    self.qqConLab = qqConLab;
    
    [self.detalView  addSubview:qqLab];
    [self.detalView  addSubview:qqConLab];
    // 微信:
    UILabel *wechatLab = [[UILabel alloc]initWithFrame:CGRectMake(10, qqConLab.mj_h + qqConLab.mj_y, 70, 30)];
    wechatLab.text = @"邮箱:";
    wechatLab.font = [UIFont systemFontOfSize:14.0];
    wechatLab.textColor = COMColor(51, 51, 51, 1.0);
//    wechatLab.textAlignment = NSTextAlignmentRight;
    self.wechatLab = wechatLab;
    
    UILabel *wechatConLab = [[UILabel alloc]initWithFrame:CGRectMake(wechatLab.mj_w,  qqConLab.mj_h + qqConLab.mj_y, self.view.mj_w - cellphoneLab.frame.size.width -10, 30)];

    wechatConLab.font = [UIFont systemFontOfSize:14.0];
    wechatConLab.textColor = COMColor(51, 51, 51, 1.0);
    wechatConLab.textAlignment = NSTextAlignmentLeft;
    wechatConLab.text = self.objec.email;
    self.wechatConLab = wechatConLab;
    
    [self.detalView  addSubview:wechatLab];
    [self.detalView  addSubview:wechatConLab];

    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, wechatConLab.mj_y + wechatConLab.mj_h + 5, self.view.mj_w , 5)];
    line4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detalView addSubview:line4];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(10, wechatConLab.mj_h + wechatConLab.mj_y + 15, 70, 30)];
    detailLab.text = @"详细说明:";
    detailLab.font = [UIFont systemFontOfSize:14.0];
    detailLab.textColor = COMColor(51, 51, 51, 1.0);
//    detailLab.textAlignment = NSTextAlignmentRight;
    self.detailLab = detailLab;
    
    UIView *detalLine = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.mj_y + detailLab.mj_h, self.view.mj_w, 0.5)];
    detalLine.backgroundColor = [UIColor grayColor];
    self.detalLine = detalLine;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake([detailLab right], detailLab.mj_y,100, detailLab.mj_h);
    [btn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn setTitle:@"点击查看详情" forState:0];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.detalView addSubview:btn];
    
    UILabel *cgLab = [[UILabel alloc]initWithFrame:CGRectMake(10, [detailLab bottom]+15, 70, 30)];
    cgLab.text = @"活动成果:";
    cgLab.font = [UIFont systemFontOfSize:14.0];
    cgLab.textColor = COMColor(51, 51, 51, 1.0);
    //    detailLab.textAlignment = NSTextAlignmentRight;
    [self.detalView addSubview:cgLab];
//    UIView *detalLine = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.mj_y + detailLab.mj_h, self.view.mj_w, 0.5)];
//    detalLine.backgroundColor = [UIColor grayColor];
//    self.detalLine = detalLine;
    
    UIButton *cgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cgBtn.frame =CGRectMake([cgLab right], cgLab.mj_y,100, cgLab.mj_h);
    [cgBtn addTarget:self action:@selector(cgDetailClick) forControlEvents:UIControlEventTouchUpInside];
    cgBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [cgBtn setTitle:@"点击查看详情" forState:0];
    cgBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.detalView addSubview:cgBtn];
    
    CGSize size1 ;
    if (!self.objec.detail || [self.objec.detail isEqualToString:@""]) {
        size1 = CGSizeMake(self.wechatConLab.mj_h + self.wechatConLab.mj_y+ 15, 30);
    }
    else
    {
        size1 = STRING_SIZE_FONT_HEIGHT(self.wechatConLab.mj_h + self.wechatConLab.mj_y+ 15, self.objec.detail, 14.0);
        if (size1.height < 80) {
            size1.height = 80;
        }
        

    }
//    UILabel *detailConLab = [[UILabel alloc]initWithFrame:CGRectMake(10, wechatConLab.mj_h + wechatConLab.mj_y + 45, self.view.mj_w - 20, size1.height)];
//    detailConLab.font = [UIFont systemFontOfSize:14.0];
//    detailConLab.textColor = COMColor(51, 51, 51, 1.0);
//    detailConLab.textAlignment = NSTextAlignmentLeft;
//    detailConLab.numberOfLines = 0;
//    detailConLab.text = self.objec.detail;
//    self.detailConLab = detailConLab;
    
    [self.detalView  addSubview:detailLab];
    [self.detalView addSubview:detalLine];
//    [self.detalView  addSubview:detailConLab];
    
    
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
    [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
    // 点赞
//    UIButton *prasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [prasBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
//    prasBtn.frame = CGRectMake(self.view.mj_w - 200, 13, 25, 25);
//    //    prasBtn.backgroundColor = [UIColor grayColor];
//    self.prasBtn = prasBtn;
//    
//    UILabel *prasNum = [[UILabel alloc]initWithFrame:CGRectMake(self.prasBtn.mj_x + self.prasBtn.mj_w, 5, 70, 40)];
//    //    prasNum.backgroundColor = [UIColor grayColor];
//    self.prasNum = prasNum;
    // 评论
    UIButton *comSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comSendBtn.frame = CGRectMake(DEF_SCREEN_WIDTH-60, 3, 25, 25);
    [comSendBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
    self.comSendBtn = comSendBtn;
    UILabel *comSendNum = [[UILabel alloc]initWithFrame:CGRectMake( self.comSendBtn.mj_w + self.comSendBtn.mj_x, 0, self.view.mj_w - self.comSendBtn.mj_w - self.comSendBtn.mj_x - 10, 30)];
    comSendNum.font = [UIFont systemFontOfSize:14.0f];
    comSendNum.text =self.results.totalElements;;
    self.comSendNum = comSendNum;
    
//    [sectionView addSubview:prasBtn];
//    [sectionView addSubview:prasNum];
    [sectionView addSubview:comSendBtn];
    [sectionView addSubview:comSendNum];
    self.sectionView = sectionView;
    [self.commentsView  addSubview:sectionView];
    
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 1, self.view.mj_w, self.view.bounds.size.height / 2) style:UITableViewStylePlain];
    comTableView.backgroundColor = [UIColor whiteColor];// DEF_RGB_COLOR(222, 222, 222);
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
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + 100) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height - 20) itemArray:@[label1,label2] contentArray:@[self.detalView,self.commentsView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    NSLog(@"%@",[common getCurrentDeviceModel:self]);
    
   
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView];
    self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100);
}
- (void)detailClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.objec.detail;
    [self.navigationController pushViewController:achVC animated:YES];
}
- (void)cgDetailClick
{
//    LoadingSiteViewController *loadVC = [[LoadingSiteViewController alloc] init];
//    loadVC.conUrl = [NSString stringWithFormat:@"%@?id=%@",DEF_HDCHENGGUO,self.listFriend.roadId];
//    [self.navigationController pushViewController:loadVC animated:YES];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@",DEF_HDCHENGGUO,self.listFriend.roadId]]];
}
- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    [self.commentText resignFirstResponder];
    self.scrollNum = index;
    if (self.scrollNum == 1)
    {
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 130);
        }
        else
        {
            
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 160);
        }
//         self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 145);
        [comTableView reloadData];
    }
    else
    {
        
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 80);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
          self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 100);
        }
        else
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 140);
        }

       
    }
}
-(void)initView
{
    self.navigationController.navigationBarHidden = NO;
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64)];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    CGSize sizeTitle = [common sizeWithString:@"" font:[UIFont systemFontOfSize:20.0f] maxSize:CGSizeMake(self.view.mj_w - 40, 0)];
    
    UILabel *titleLab = [common createLabelWithFrame:CGRectZero andText:self.strTitle];
    titleLab.frame = CGRectMake(10, 10, self.view.mj_w - 20, sizeTitle.height);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont systemFontOfSize:18.0f];
    titleLab.text = self.listFriend.theme;
    [sc addSubview:titleLab];
    self.titleLab = titleLab;
    
    UIImageView *imclock = [[UIImageView alloc] init];
    imclock.frame = CGRectMake(10,[titleLab bottom]+10, 15, 15);
    imclock.image = [UIImage imageNamed:@"clock"];
    [sc addSubview:imclock];
    self.imClock = imclock;
    
    UILabel *lblDat = [common createLabelWithFrame:CGRectZero andText:self.strd];
    lblDat.frame = CGRectMake([imclock right]+8,imclock.mj_y-2, 70, 20);
    lblDat.font = [UIFont systemFontOfSize:14.0f];
    lblDat.text = @"开始时间:";
    [sc addSubview:lblDat];
    self.lblDat = lblDat;
    
    
    UILabel *lblDate = [common createLabelWithFrame:CGRectZero andText:self.strd];
    lblDate.frame = CGRectMake(lblDat.mj_w + lblDat.mj_x ,lblDat.mj_y, 200, 20);
    lblDate.font = [UIFont systemFontOfSize:14.0f];
    lblDate.text = [common sectionStrByCreateTime:self.objec.startDate];
    [sc addSubview:lblDate];
    self.lblDate = lblDate;
    
    
    UIImageView *im = [[UIImageView alloc] init];
    im.frame = CGRectMake(10, lblDat.mj_y + lblDat.mj_h + 10, self.view.mj_w - 20 , (self.view.mj_w - 20)/ 5 * 3);
    im.layer.masksToBounds = YES;
    [im sd_setImageWithURL:[NSURL URLWithString:self.objec.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    [sc addSubview:im];
    self.im = im;
    im.hidden = self.isHide;
    
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     praiseBtn.frame = CGRectMake(10, im.mj_y + im.mj_h + 20, 25 , 25);
    [praiseBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    praiseBtn.layer.masksToBounds = YES;
    praiseBtn.layer.cornerRadius = 4;
    self.praiseBtn = praiseBtn;
    [sc addSubview:praiseBtn];
    
    UILabel *praiseLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
    praiseLab.frame = CGRectMake([praiseBtn right]+5,praiseBtn.mj_y,70 , 25);
    praiseLab.font = [UIFont systemFontOfSize:14.0f];
    praiseLab.text = [NSString stringWithFormat:@"%d",self.objec.praiseCount];
    [sc addSubview:praiseLab];
    self.praiseLab = praiseLab;
    
//    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    commentBtn.frame = CGRectMake([praiseLab right]+5, praiseBtn.mj_y, 25, 25);
//    [commentBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
//    [sc addSubview:commentBtn];
//
//    UILabel *commentLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
//    commentLab.frame = CGRectMake([commentBtn right]+5,commentBtn.mj_y,70 , 25);
//    commentLab.font = [UIFont systemFontOfSize:14.0f];
//    commentLab.text = self.objec.commentNum;
//    [sc addSubview:commentLab];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
     signUpBtn.frame = CGRectMake(self.view.mj_w - 80 , im.mj_y + im.mj_h + 20, 70, 25);
    [signUpBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(signUpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.layer.masksToBounds = YES;
    signUpBtn.layer.cornerRadius = 4;
    signUpBtn.layer.borderWidth = 1;
    signUpBtn.tintColor = GREENCOLOR;
    signUpBtn.layer.borderColor = GREENCOLOR.CGColor;
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.signUpBtn = signUpBtn;
    [sc addSubview:signUpBtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(self.view.mj_w - 90 , im.mj_y + im.mj_h + 20, 80, 25);
    [btn setTitle:@"已过期" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.tintColor = GREENCOLOR;
    btn.layer.borderColor = GREENCOLOR.CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sc addSubview:btn];
    self.endBtn = btn;
//    self.endLab = [[UILabel alloc] init];
//    self.endLab.frame = CGRectMake(DEF_SCREEN_WIDTH/2, im.mj_y + im.mj_h + 20, DEF_SCREEN_WIDTH/2, 25);
////    self.endLab.text = @"活动已结束";
//    self.endLab.font = [UIFont systemFontOfSize:13];
//    self.endLab.textColor = GREENCOLOR;
//    self.endLab.hidden = YES;
//    [sc addSubview:self.endLab];
//    self.endLab.textAlignment = NSTextAlignmentCenter;
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, signUpBtn.mj_h + signUpBtn.mj_y + 10, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [sc addSubview:grayView];
    
    sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 200);
    self.sc = sc;
    [self.view addSubview:sc];

}
//- (void)reloadChengguoTabview
//{
//    NumArr = [NSMutableArray array];
//    WEAKSELF;
//    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTDETAIL params:@{@"id":self.listFriend.roadId} complete:^(BOOL successed, NSDictionary *result) {
//        if (successed)
//        {
//            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
//            {
//                Result *data = [Result objectWithKeyValues:result[@"lists"]];
//                weakSelf.totalPage = data.totalPages;
////                [NumArr removeAllObjects];
//                [NumArr addObjectsFromArray:data.content];
//                
//                [tableview reloadData];
//            }
//        }
//    }];
//}
- (void)loadResult:(Result *)resultVo
{
    self.titleLab.text              = resultVo.name;
    self.lblDate.text               = resultVo.createDate;
    self.praiseLab.text             = resultVo.praiseCount;
    self.cellphConLab.text          = resultVo.cellphone;
    self.mobileConLab.text          = resultVo.mobile;
    self.qqConLab.text              = resultVo.qq;
    self.wechatConLab.text          = resultVo.wechat;
//    self.detailConLab.text          = resultVo.detail;
//    self.addressConLab.text         = resultVo.address;
//    self.applyRuleConLab.text       = resultVo.applyRule;
    self.clockImLab.text   = resultVo.typeName;
//    self.briefDescriptionConLab.text= resultVo.briefDescription;
    
    [self.im sd_setImageWithURL:[NSURL URLWithString:resultVo.iconImag] placeholderImage:[UIImage imageNamed:@"picf"]];
}

- (void)praiseBtnAction:(UIButton *)sender
{
    if (selectNum%2==1) {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_DIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8"} complete:^(BOOL successed, NSDictionary *result) {
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
        [[HttpManager defaultManager] postRequestToUrl:DEF_QUXIAODIANZAN params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8"} complete:^(BOOL successed, NSDictionary *result) {
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
#pragma mark - UIButton Select Action
- (void)sendBtnAction
{
    self.sendBtn.enabled = NO;
    if ([self.commentText.text isEqualToString:@""]) {
        showAlertView(@"评论内容不能为空");
        self.sendBtn.enabled = YES;
        return ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_SENDCOMMENT params:@{@"businessId":self.listFriend.roadId,@"categoryId":@"8",@"content":self.commentText.text} complete:^(BOOL successed, NSDictionary *result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            //
            if ([result[@"code"] isEqualToString:@"10000"]) {
                
                weakSelf.commentText.text = @"";
                [weakSelf headerRefreshing];
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
        self.sendBtn.enabled = YES;
    }];
}

- (void)signUpBtnAction
{
    ActiveSignViewController *signUpVC = [[ActiveSignViewController alloc]init];
    signUpVC.ActivId = self.listFriend.roadId;
    [self.navigationController pushViewController:signUpVC animated:YES];
}

#pragma mark - tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.scrollNum == 1)
    {
        //        return comDateModelArr.count;
//        NSLog(@"%ld",self.results.content.count);
        return _cellNumArr.count;
    }
//    else  if (self.scrollNum == 2)
//    {
//        return NumArr.count;
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
//        ListFriend *listFri = [NumArr objectAtIndex:indexPath.row];
//        cell.detailLab.text = listFri.content;
//        cell.dateLab.text = [common sectionStrByCreateTime:listFri.createDate];
//        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:self.objec.imageHead.absoluteImagePath] placeholderImage:nil];
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
//        ListFriend *re = [NumArr objectAtIndex:indexPath.row];
//        AchievementViewController *achVC = [[AchievementViewController alloc] init];
//        achVC.contentStr = re.content;
//        [self.navigationController pushViewController:achVC animated:YES];
//    }
    else
    {
        
    }
}

#pragma mark - textField  Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
