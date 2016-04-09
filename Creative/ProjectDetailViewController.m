//
//  ProjectDetailViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectDetailViewController.h"
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
#import "PersonalViewController.h"
#import "LoadingSiteViewController.h"
#import "AchievementViewController.h"
@interface ProjectDetailViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,WJSliderViewDelegate>
{
    UITableView *comTableView;
    NSMutableArray *comDateModelArr;
    NSMutableArray *noteDateArr;
    int selectNum;
    int relation;
    CGFloat heights;
     CGSize size1 ;
     CGSize size2 ;
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

@property (nonatomic , strong) UILabel *InvestmentLab; //筹资天数
@property (nonatomic , strong) UILabel *InvestmentConLab;
// 发起地点
@property (nonatomic , strong) UILabel *areaLab;
@property (nonatomic , strong) UILabel *areaConLab;
// 项目方向
@property (nonatomic , strong) UILabel *leftLab;
@property (nonatomic , strong) UILabel *leftConLab;
// 第三方网址
@property (nonatomic , strong) UILabel *wwwLab;
@property (nonatomic , strong) UILabel *wwwConLab;

@property (nonatomic , strong) UILabel *briefDescriptionLab;
@property (nonatomic , strong) UILabel *briefDescriptionConLab;
// 详细说明
@property (nonatomic , strong) UILabel *detailLab;
@property (nonatomic , strong) UIView *line22;
@property (nonatomic , strong) UILabel *detailConLab;
// 报名规则
@property (nonatomic , strong) UILabel *applyRuleLab;
@property (nonatomic , strong) UIImageView *applyRuleConLab;

// 留言
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
@property (nonatomic , strong) UIButton *publicBtn;
@property (nonatomic , strong) UIButton *praiteBtn;
@property (nonatomic , copy) NSString *publicityType;

@property (nonatomic,strong)Object *objec;
@property (nonatomic , strong) Result *results;
@property(nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic , strong) UIImageView *arrowImage;
@property (nonatomic , strong) UIButton *titleBtn;
@property (nonatomic , strong) UIView *vidoView;
@property (nonatomic , strong) UIButton *videoBtn;

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = self.listFried.name;
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
    [[HttpManager defaultManager] postRequestToUrl:DEF_PROJECTDETAIL params:@{@"id":self.listFried.roadId,@"delFlg":@"0"} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
//            [MBProgressHUD showSuccess:[result objectForKey:@"msg"] toView:nil];
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                Object *obj = [Object objectWithKeyValues:result[@"obj"]];
                weakSelf.objec = obj;
                self.briefDescriptionConLab.text = self.objec.oneSentenceDesc;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
                dispatch_async(queue, ^{
                    //获取关注状态
                    WEAKSELF;
                    [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUGUANZHU params:@{@"otherUserId":DEF_USERID} complete:^(BOOL successed, NSDictionary *result) {
                        if (successed)
                        {
                            NSString *rela =result[@"obj"][@"isRelation"];
                            relation = [rela intValue];
                            if ([result[@"code"] isEqualToString:@"10000"]) {
                                if ([rela isEqualToString:@"1"]) {
                                    weakSelf.focusLab.text =@"关注";                                }else
                                    {
                                        weakSelf.focusLab.text =@"取消关注";
                                    }
                            }
                        }
                    }];
                    //获取点赞状态
                    [[HttpManager defaultManager] postRequestToUrl:DEF_HUOQUDIANZAN params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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
                NSDate *dat = [NSDate dateWithTimeIntervalSince1970:(self.objec.finishDate / 1000)];
                if ([dat isEarlierThanDate:[NSDate date]]==YES)
                {
                    self.endBtn.hidden = NO;
                    self.signUpBtn.hidden = YES;
                }else
                {
                    self.endBtn.hidden = YES;
                    self.signUpBtn.hidden = NO;
                }
            }
        }
        [weakSelf.hud hide:YES];
    }];
    
    /**
     * 获取项目留言列表
     */
//    [self loadNoteList];
}
/**
 * 获取项目留言列表
 */
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [comTableView.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [comTableView.header endRefreshing];
                Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
                self.comSendNum.text = resul.totalElements;
                weakSelf.results = resul;
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
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
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
//    WEAKSELF;
//    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9",@"pageNumber": @(1),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
//        if (successed)
//        {
//            Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
//            weakSelf.results = resul;
//            [comTableView reloadData];
//            
//        }
//    }];
//}
- (void)initView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, self.view.mj_h-64)];
    sc.backgroundColor = [UIColor whiteColor];
    
    
    UIView *titleView = [[UIView alloc]init];
     titleView.userInteractionEnabled = YES;
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:self.objec.userInfo.imageUrl] placeholderImage:[UIImage imageNamed:@"picf"]];
    iconImage.userInteractionEnabled = YES;
    [titleView addSubview:iconImage];
    self.iconImage = iconImage;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor grayColor];
    [sc addSubview:line];
    self.line = line;
    
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = @"发起人:";
    nameLab.font = [UIFont systemFontOfSize:15];
    self.nameLab = nameLab;
    
    UILabel *nameText = [[UILabel alloc]init];
    nameText.text = self.objec.userInfo.loginName;
    nameText.textColor = [UIColor lightGrayColor];
    nameText.font = [UIFont systemFontOfSize:15];
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
    
    // 详情头部
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setBackgroundImage:[UIImage imageNamed:@"gz"] forState:0];
//    [addBtn addTarget:self action:@selector(focusClick) forControlEvents:UIControlEventTouchUpInside];
//    [titleView addSubview:addBtn];
//    self.addBtn = addBtn;
//    
//    UILabel *focusLab = [[UILabel alloc]init];
//    focusLab.font = [UIFont systemFontOfSize:15];
//    [titleView addSubview:focusLab];
//    self.focusLab = focusLab;
//    
//    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [msgBtn addTarget:self action:@selector(msgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [msgBtn setBackgroundImage:[UIImage imageNamed:@"sixin"] forState:UIControlStateNormal];
//    [titleView addSubview:msgBtn];
//    self.msgBtn = msgBtn;
//    
//    UILabel *msgLab = [[UILabel alloc]init];
//    msgLab.text = @"私信";
//    msgLab.font = [UIFont systemFontOfSize:15];
//    [titleView addSubview:msgLab];
//    self.msgLab = msgLab;
    
    //    titleView.backgroundColor = [UIColor lightGrayColor];
    [sc addSubview:titleView];
    self.titleView = titleView;
    
    UILabel *titleLab = [common createLabelWithFrame:CGRectZero andText:self.strTitle];
        titleLab.numberOfLines = 0;
        titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:17.0];
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
    placeLab.text = [NSString stringWithFormat:@"%@   %@",self.objec.provinceName,self.objec.cityName];
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
    [praiseBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    praiseBtn.layer.masksToBounds = YES;
    praiseBtn.layer.cornerRadius = 4;
    self.praiseBtn = praiseBtn;
    [sc addSubview:praiseBtn];
    
    UILabel *praiseLab = [common createLabelWithFrame:CGRectZero andText:self.strd];
    praiseLab.font = [UIFont systemFontOfSize:14.0f];
    praiseLab.text = [NSString stringWithFormat:@"%d",self.objec.praiseCount];
    [sc addSubview:praiseLab];
    self.praiseLab = praiseLab;
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [signUpBtn setTitle:@"我要支持" forState:UIControlStateNormal];
    [signUpBtn addTarget:self action:@selector(signUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.layer.masksToBounds = YES;
    signUpBtn.layer.cornerRadius = 4;
    signUpBtn.layer.borderWidth = 1;
    signUpBtn.tintColor = GREENCOLOR;
    signUpBtn.layer.borderColor = GREENCOLOR.CGColor;
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    if (self.YNtwo) {
        signUpBtn.hidden = YES;
    }
    else
    {
        signUpBtn.hidden = NO;
    }
    self.signUpBtn = signUpBtn;
    [sc addSubview:signUpBtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"已过期" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.tintColor = GREENCOLOR;
    btn.layer.borderColor = GREENCOLOR.CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sc addSubview:btn];
    self.endBtn = btn;
    
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
    SupportViewController *supVC = [[SupportViewController alloc] init];
    supVC.objc = self.objec;
    [self.navigationController pushViewController:supVC animated:YES];
}

- (void)titleViewAction:(UIButton *)sender
{
    PersonalViewController *perVC = [[PersonalViewController alloc] init];
    perVC.obj = self.objec;
    [self.navigationController pushViewController:perVC animated:YES];
}

- (void)praiseBtnAction:(UIButton *)sender
{
    if (selectNum%2==1) {
        [self.praiseBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:DEF_DIANZAN params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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
        [[HttpManager defaultManager] postRequestToUrl:DEF_QUXIAODIANZAN params:@{@"businessId":self.listFried.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
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
    
//    self.arrowImage.frame = CGRectMake(self.nameText.mj_w + self.nameText.mj_x + 5, self.nameText.mj_y, 10, 20);
    self.arrowImage.center = CGPointMake([self.nameText right]+5, self.titleView.mj_h/2);
    self.arrowImage.bounds = CGRectMake(0, 0, 10, 20);
//    self.addBtn.frame = CGRectMake(self.iconImage.mj_w + self.iconImage.mj_x + 5, self.line.mj_h + self.line.mj_y + 5, 25, 25);
//    self.focusLab.frame = CGRectMake(self.addBtn.mj_x + self.addBtn.mj_w, self.line.mj_h + self.line.mj_y + 8, 100, 25);
//    self.msgBtn.frame = CGRectMake(self.view.mj_w  - 100, self.line.mj_h + self.line.mj_y + 8, 25, 25);
//    self.msgLab.frame = CGRectMake(self.msgBtn.mj_w + self.msgBtn.mj_x, self.msgBtn.mj_y, 50, 25);
    UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleView.mj_h + self.titleView.mj_y + 2, self.view.mj_w, 5)];
    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.sc addSubview:grayView1];
    
    self.titleLab.frame = CGRectMake(10, self.titleView.mj_y + self.titleView.mj_h + 10, self.view.mj_w -20, 30);
    
    self.imClock .frame = CGRectMake(10,  self.titleLab.mj_h + self.titleLab.mj_y + 18, 15, 15);
    
    self.lblDat.frame = CGRectMake(self.imClock.mj_w + self.imClock.mj_x,self.titleLab.mj_h + self.titleLab.mj_y + 16, 70, 20);
    self.lblDate.frame = CGRectMake(self.lblDat.mj_w + self.lblDat.mj_x ,self.titleLab.mj_y+ self.titleLab.mj_h + 15,90, 20);
    
    self.placeImage.frame = CGRectMake(self.lblDate.mj_x + self.lblDate.mj_w + 2, self.imClock.mj_y, 15, 15);
    
    self.placeLab.frame = CGRectMake(self.placeImage.mj_x + self.placeImage.mj_w + 3, self.lblDate.mj_y, self.view.mj_w - self.placeImage.mj_x - self.placeImage.mj_w - 13, self.lblDate.mj_h);
    
    self.im.frame = CGRectMake(10, self.lblDat.mj_y + self.lblDat.mj_h + 20, self.view.mj_w - 20 , (self.view.mj_w - 20) / 5 * 3);
    
    self.praiseBtn.frame = CGRectMake(10, self.im.mj_y + self.im.mj_h + 20, 25 , 25);
    self.praiseLab.frame = CGRectMake(self.praiseBtn.mj_w + self.praiseBtn.mj_x , self.im.mj_y + self.im.mj_h + 20, 100 , 25);
    self.signUpBtn.frame = CGRectMake(self.view.mj_w - 80 , self.im.mj_y + self.im.mj_h + 20, 70, 25);
    self.endBtn.frame = CGRectMake(self.view.mj_w - 80, self.im.mj_y + self.im.mj_h + 20,70, 25);
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 10, self.view.mj_w, 5)];
    grayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.sc addSubview:grayView];
    
    
    
    self.detailView = [UIView new];
    
    UILabel *InvestmentLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    InvestmentLab.text = @"筹资天数:";
    InvestmentLab.font = [UIFont systemFontOfSize:14.0];
    InvestmentLab.textColor = COMColor(51, 51, 51, 1.0);
    InvestmentLab.textColor = [UIColor lightGrayColor];
    InvestmentLab.textAlignment = NSTextAlignmentRight;
    self.InvestmentLab = InvestmentLab;
    
    UILabel *InvestmentConLab = [[UILabel alloc]initWithFrame:CGRectMake(InvestmentLab.frame.size.width, 0, self.view.mj_w - InvestmentLab.frame.size.width -10, 30)];
    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
    InvestmentConLab.font = [UIFont systemFontOfSize:14.0];
    InvestmentConLab.textColor = COMColor(51, 51, 51, 1.0);
    InvestmentConLab.textAlignment = NSTextAlignmentLeft;
    InvestmentConLab.text = [NSString stringWithFormat:@"%d",self.objec.financleDays];
    self.InvestmentConLab = InvestmentConLab;
    
    [self.detailView  addSubview:InvestmentLab];
    [self.detailView  addSubview:InvestmentConLab];
    
    // 手机:
    UILabel *areaLab = [[UILabel alloc]initWithFrame:CGRectMake(0, InvestmentConLab.mj_h + InvestmentConLab.mj_y , 70, 30)];
    areaLab.text = @"发起地点:";
    areaLab.font = [UIFont systemFontOfSize:14.0];
    areaLab.textColor = COMColor(51, 51, 51, 1.0);
    areaLab.textColor = [UIColor lightGrayColor];
    areaLab.textAlignment = NSTextAlignmentRight;
    self.areaLab = areaLab;
    
    UILabel *areaConLab = [[UILabel alloc]initWithFrame:CGRectMake(areaLab.mj_w, InvestmentConLab.mj_h + InvestmentConLab.mj_y, self.view.mj_w - InvestmentLab.frame.size.width -10, 30)];
    areaConLab.text = [NSString stringWithFormat:@"%@ %@",[common checkStrValue:self.objec.provinceName],[common checkStrValue:self.objec.cityName]];
    areaConLab.font = [UIFont systemFontOfSize:14.0];
    areaConLab.textColor = COMColor(51, 51, 51, 1.0);
    areaConLab.textAlignment = NSTextAlignmentLeft;
    self.areaConLab = areaConLab;
    
    [self.detailView  addSubview:areaLab];
    [self.detailView  addSubview:areaConLab];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, areaConLab.mj_h + areaConLab.mj_y, 70, 30)];
    leftLab.text = @"项目方向:";
    leftLab.font = [UIFont systemFontOfSize:14.0];
    leftLab.textColor = COMColor(51, 51, 51, 1.0);
    leftLab.textColor = [UIColor lightGrayColor];
    leftLab.textAlignment = NSTextAlignmentRight;
    self.leftLab = leftLab;
    
    UILabel *leftConLab = [[UILabel alloc]initWithFrame:CGRectMake(leftLab.mj_w,  areaConLab.mj_h + areaConLab.mj_y, self.view.mj_w - InvestmentLab.frame.size.width -10, 30)];
    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
    leftConLab.font = [UIFont systemFontOfSize:14.0];
    leftConLab.textColor = COMColor(51, 51, 51, 1.0);
    leftConLab.textAlignment = NSTextAlignmentLeft;
    leftConLab.text = [common checkStrValue:self.objec.typeName];
    self.leftConLab = leftConLab;
    
    [self.detailView  addSubview:leftLab];
    [self.detailView  addSubview:leftConLab];
    
    UILabel *wwwLab = [[UILabel alloc]initWithFrame:CGRectMake(0, leftConLab.mj_h + leftConLab.mj_y, 70, 30)];
    wwwLab.text = @"众筹支持:";
    wwwLab.font = [UIFont systemFontOfSize:14.0];
    wwwLab.textColor = COMColor(51, 51, 51, 1.0);
    wwwLab.textColor = [UIColor lightGrayColor];
    wwwLab.textAlignment = NSTextAlignmentRight;
    self.wwwLab = wwwLab;
   
    if (!self.objec.thirdPartyUrl || [self.objec.thirdPartyUrl isEqualToString:@""]) {
        size1 = CGSizeMake(self.view.mj_w - InvestmentLab.frame.size.width -10, 30);
    }
    else
    {
    
   size1 = STRING_SIZE_FONT_HEIGHT(self.view.mj_w - InvestmentLab.frame.size.width -10, self.objec.thirdPartyUrl, 14.0);
        if (size1.height < 30) {
            size1.height = 30;
        }
    }
//    UILabel *wwwConLab = [[UILabel alloc]initWithFrame:CGRectMake(wwwLab.mj_w,  leftConLab.mj_h + leftConLab.mj_y, self.view.mj_w - InvestmentLab.frame.size.width -10, size1.height)];
//    //    directionTypeConLab.text = [NSString stringWithFormat:@"%@",labContent];
//    wwwConLab.font = [UIFont systemFontOfSize:14.0];
//    wwwConLab.numberOfLines = 0;
//    wwwConLab.adjustsFontSizeToFitWidth = YES;
//    wwwConLab.textColor = COMColor(51, 51, 51, 1.0);
//    wwwConLab.textAlignment = NSTextAlignmentLeft;
//    wwwConLab.text = self.objec.thirdPartyUrl;
//    self.wwwConLab = wwwConLab;
    
    UIButton *wwwBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    wwwBtn.frame = CGRectMake([wwwLab right], wwwLab.mj_y, 100, wwwLab.mj_h);
    wwwBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [wwwBtn setTitle:@"点击查看详情" forState:0];
    [wwwBtn addTarget:self action:@selector(wwwClick) forControlEvents:UIControlEventTouchUpInside];
    wwwBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.detailView addSubview:wwwBtn];
    
    [self.detailView  addSubview:wwwLab];
//    [self.detailView  addSubview:wwwConLab];
    self.applyRuleLab.frame = CGRectMake(0, self.detailLab.mj_h + self.detailLab.mj_y + 80, 70, 30);
    self.vidoView.frame = CGRectMake([self.applyRuleLab right]+20, self.applyRuleLab.mj_y, DEF_SCREEN_WIDTH/2, DEF_SCREEN_WIDTH/2*3/4);
    self.videoBtn.bounds = CGRectMake(0, 0, self.vidoView.mj_h/3, self.vidoView.mj_h/3);
    
    UIView *grayView21 = [[UIView alloc]initWithFrame:CGRectMake(0, wwwBtn.mj_y + wwwBtn.mj_h + 10, self.view.mj_w, 5)];
    grayView21.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView21];
    

    
    UILabel *briefDescriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, wwwBtn.mj_h + wwwBtn.mj_y + 35, self.view.mj_w - 20, 30)];
    briefDescriptionLab.text = @"项目简介:";
    briefDescriptionLab.font = [UIFont systemFontOfSize:14.0];
    briefDescriptionLab.textColor = [UIColor lightGrayColor];
    briefDescriptionLab.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *lineintro = [[UIView alloc]initWithFrame:CGRectMake(10, briefDescriptionLab.mj_y + briefDescriptionLab.mj_h, self.view.mj_w - 20, 1)];
    lineintro.backgroundColor =  [UIColor lightGrayColor];
    
   
    if (!self.objec.oneSentenceDesc || [self.objec.oneSentenceDesc isEqualToString:@""]) {
        size2 = CGSizeMake(DEF_SCREEN_WIDTH-20, 30);
    }
    else
    {
        size2 = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.objec.oneSentenceDesc, 14.0);
        if (size2.height < 30) {
            size2.height = 30;
        }
        
    }
    UILabel *briefDescriptionConLab = [[UILabel alloc]initWithFrame:CGRectMake(10, briefDescriptionLab.mj_h + briefDescriptionLab.mj_y+ 15, self.view.mj_w - 20 , size2.height)];
    briefDescriptionConLab.font = [UIFont systemFontOfSize:14.0];
    briefDescriptionConLab.textColor = COMColor(51, 51, 51, 1.0);
    briefDescriptionConLab.numberOfLines = 0;
    briefDescriptionConLab.adjustsFontSizeToFitWidth = NO;
    briefDescriptionConLab.textAlignment = NSTextAlignmentLeft;
    briefDescriptionConLab.text = self.objec.oneSentenceDesc;
    [self.detailView  addSubview:briefDescriptionLab];
    [self.detailView  addSubview:briefDescriptionConLab];

    self.briefDescriptionLab = briefDescriptionLab;
    self.briefDescriptionConLab = briefDescriptionConLab;
    

    [self.detailView addSubview:lineintro];

    
    
    UIView *grayView22 = [[UIView alloc]initWithFrame:CGRectMake(0, briefDescriptionConLab.mj_y + briefDescriptionConLab.mj_h + 10, self.view.mj_w, 5)];
    grayView22.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView22];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(10, briefDescriptionConLab.mj_y + briefDescriptionConLab.mj_h + 35, 70, 30)];
    detailLab.text = @"详细说明：";
    detailLab.font = [UIFont systemFontOfSize:14.0];
    detailLab.textColor = [UIColor lightGrayColor];
    detailLab.textAlignment = NSTextAlignmentLeft;
    
    UIView *line22 = [[UIView alloc]initWithFrame:CGRectMake(10, detailLab.mj_y + detailLab.mj_h, self.view.mj_w - 20, 1)];
    line22.backgroundColor =  [UIColor lightGrayColor];
    
//    CGSize size3 ;
//    if (!self.objec.proDescription || [self.objec.proDescription isEqualToString:@""]) {
//        size3 = CGSizeMake(self.view.mj_w - detailLab.frame.size.width, 30);
//    }
//    else
//    {
//        size3 = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-20, self.objec.proDescription, 14.0);
//        if (size3.height < 30) {
//            size3.height = 30;
//        }
//    }
//    UILabel *detailConLab = [[UILabel alloc]initWithFrame:CGRectMake(10, detailLab.mj_h + detailLab.mj_y  + 1, self.view.mj_w - 20 , size3.height)];
//    detailConLab.font = [UIFont systemFontOfSize:14.0];
//    detailConLab.textColor = COMColor(51, 51, 51, 1.0);
//    detailConLab.numberOfLines = 0;
//    detailConLab.textAlignment = NSTextAlignmentLeft;
//    detailConLab.text = self.objec.proDescription;
    
    UIButton *smBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    smBtn.frame = CGRectMake([detailLab right], detailLab.mj_y, 100, detailLab.mj_h);
    smBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [smBtn setTitle:@"点击查看详情" forState:0];
    smBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [smBtn addTarget:self action:@selector(shuomingClick) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:smBtn];
    
    [self.detailView  addSubview:detailLab];
//    [self.detailView  addSubview:detailConLab];
    [self.detailView addSubview:line22];
   
    
//    self.detailConLab = detailConLab;
    self.detailLab = detailLab;
    self.line22 =line22;
    
    UIView *grayView18 = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.mj_y + detailLab.mj_h + 25, self.view.mj_w, 5)];
    grayView18.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.detailView addSubview:grayView18];
    
    UILabel *applyRuleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, detailLab.mj_h + detailLab.mj_y + 35, 70, 30)];
    applyRuleLab.text = @"项目视频:";
    applyRuleLab.font = [UIFont systemFontOfSize:14.0];
    applyRuleLab.textColor =[UIColor lightGrayColor];
    applyRuleLab.textAlignment = NSTextAlignmentRight;
    self.applyRuleLab = applyRuleLab;
    
    UIView *vidoView = [[UIView alloc] initWithFrame:CGRectMake([applyRuleLab right]+20, applyRuleLab.mj_y, DEF_SCREEN_WIDTH/2, DEF_SCREEN_WIDTH/2*3/4)];
    vidoView.backgroundColor = [UIColor lightGrayColor];
    [self.detailView addSubview:vidoView];
    self.vidoView = vidoView;
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.center = CGPointMake(vidoView.mj_w/2, vidoView.mj_h/2);
    videoBtn.bounds = CGRectMake(0, 0, vidoView.mj_h/3, vidoView.mj_h/3);
    [videoBtn setBackgroundImage:[UIImage imageNamed:@"c-1"] forState:0];
    [videoBtn addTarget:self action:@selector(openVideo) forControlEvents:UIControlEventTouchUpInside];
    [vidoView addSubview:videoBtn];
    self.videoBtn = videoBtn;
  
//    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, applyRuleLab.mj_h + applyRuleLab.mj_y, self.view.mj_w, 150)];
//    web.backgroundColor = [UIColor redColor];
//    NSURL *url =[NSURL URLWithString:self.objec.videoAddress];
//    [web loadRequest:[NSURLRequest requestWithURL:url]];
//    [self.detailView addSubview:web];
    
    [self.detailView  addSubview:applyRuleLab];
    //    [self.detailView  addSubview:applyRuleConLab];
    
    //////////  留言  ///////////////////////////
    self.notesView = [UIView new];
    
    
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
    
    UILabel *publicLab = [[UILabel alloc]initWithFrame:CGRectMake(publicBtn.mj_x + publicBtn.mj_w, publicBtn.mj_y - 5, 40, 30)];
    publicLab.text = @"公开";
    
    self.publicityType = @"0";
    [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateNormal];
    [self.praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    
    [commentView addSubview:publicBtn];
    [commentView addSubview:publicLab];
    
    UIButton *praiteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [praiteBtn setFrame:CGRectMake(publicLab.mj_x + publicLab.mj_w+ 10, publicBtn.mj_y, 20, 20)];
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
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.commentView.mj_y + self.commentView.mj_h + 10, self.view.mj_w, 50)];
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
    
    if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
    { //新增判断4s
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size2.height + size1.height + 40) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size2.height + size1.height+50) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    else
    {
        self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.signUpBtn.mj_h + self.signUpBtn.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + size2.height + size1.height - 40) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
        self.wjScroll.delegate = self;
        [self.sc addSubview:self.wjScroll];
    }
    NSLog(@"%@",[common getCurrentDeviceModel:self]);
    
    
    UIView *grayView12 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView12.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView12];
   
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + 1, self.view.mj_w, self.view.bounds.size.height /2 ) style:UITableViewStylePlain];
    comTableView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [comTableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [self.notesView addSubview:comTableView];
    
     self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h  + 280 + size2.height + size1.height);
    heights = size2.height + size1.height;
}
- (void)openVideo
{
//    LoadingSiteViewController *loadVC = [[LoadingSiteViewController alloc] init];
//    loadVC.conUrl = [NSString stringWithFormat:@"%@?videoId=%d",DEF_LYSHIPIN,self.objec.videoId];
//    [self.navigationController pushViewController:loadVC animated:YES];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?videoId=%d",DEF_LYSHIPIN,self.objec.videoId]]];
}
- (void)wwwClick
{
    LoadingSiteViewController *loadVC = [[LoadingSiteViewController alloc] init];
    loadVC.conUrl = self.objec.thirdPartyUrl;
    [self.navigationController pushViewController:loadVC animated:YES];
}
- (void)shuomingClick
{
    AchievementViewController *achVC = [[AchievementViewController alloc] init];
    achVC.titl = @"详情";
    achVC.contentStr = self.objec.proDescription;
    NSLog(@"--->%@",self.objec.proDescription);
    [self.navigationController pushViewController:achVC animated:YES];
}
#pragma mark - UIButton Select Action
- (void)sendBtnAction
{
    self.sendBtn.enabled = NO;
    if ([self.commentText.text isEqualToString:@""]) {
        showAlertView(@"留言内容不能为空");
        self.sendBtn.enabled = YES;
        return ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ADDNOTES params:@{@"receiverId":self.listFried.createBy,@"publicityType":self.publicityType,@"content":self.commentText.text,@"businessId":self.listFried.roadId,@"categoryId":@"9"} complete:^(BOOL successed, NSDictionary *result) {
        //
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

#pragma mark - tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

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

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    if (index == 1)
    {

        
        
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 125);
            [comTableView reloadData];
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 145);
            [comTableView reloadData];
        }
        else
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 160);
            [comTableView reloadData];
        }
        NSLog(@"%@",[common getCurrentDeviceModel:self]);
    }
    else
    {
        if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 4S (A1387/A1431)"])
        { //新增判断4s
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h  + 250 + heights);
        }
        else if ([[common getCurrentDeviceModel:self]isEqualToString:@"iPhone 5s (A1453/A1533)"])
        {
            self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h  + 200 + heights);
        }
        else
        {
           self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h  + 150 + heights);
        }

        
    }
    [self.commentText resignFirstResponder];
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
