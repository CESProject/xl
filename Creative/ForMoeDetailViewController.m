//
//  ForMoeDetailViewController.m
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ForMoeDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "DeliveryViewController.h"
#import "CommentsTableViewCell.h"
#import "Object.h"
#import "Result.h"
@interface ForMoeDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WJSliderViewDelegate>
{
    UITableView *comTableView;
    UITableView *tableview;
    BOOL            *_flag;
}
@property (strong, nonatomic) NSMutableArray *cellNumArr;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPage;

@property (nonatomic , strong)  UIView *titleView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *postBtn;

@property(nonatomic,weak)UIScrollView *sc;

@property (nonatomic , strong) UIView *sectionView;
@property (nonatomic , strong) UILabel *sectionLab;
@property (nonatomic , strong) UIImageView *dateIm;
@property (nonatomic , strong)  UILabel *dateLab;
@property (nonatomic , strong) UILabel *dateConLab;
@property (nonatomic , strong) UIImageView *lookIm;
@property (nonatomic , strong) UILabel *lookLab;
@property (nonatomic , strong) UILabel *lookConLab;


////////////////////////
@property (nonatomic , strong) UILabel *monMainLab; //筹资天数
@property (nonatomic , strong) UILabel *monMainConLab;
// 发起地点
@property (nonatomic , strong) UILabel *guildLab;
@property (nonatomic , strong) UILabel *guildConLab;
// 项目方向
@property (nonatomic , strong) UILabel *amountLab;
@property (nonatomic , strong) UILabel *amountConLab;
// 第三方网址
@property (nonatomic , strong) UILabel *dataLab;
@property (nonatomic , strong) UILabel *dataConLab;

@property (nonatomic , strong) UILabel *areaLab;
@property (nonatomic , strong) UILabel *areaConLab;
// 详细说明
@property (nonatomic , strong) UILabel *placeLab;
@property (nonatomic , strong) UILabel *placeConLab;
// 报名规则
@property (nonatomic , strong) UILabel *costLab;
@property (nonatomic , strong) UILabel *costConLab;

// 留言
@property (nonatomic ,strong) UIView *commentView;
@property (nonatomic , strong) UITextField *commentText;
@property (nonatomic , strong) UIButton *sendBtn;

@property (nonatomic , strong) UIView *NotesectionView;
@property (nonatomic , strong) UILabel *commentNum;
@property (nonatomic , strong) UIButton *prasBtn;
@property (nonatomic , strong) UILabel *prasNum;
@property (nonatomic , strong) UIButton *comSendBtn;
@property (nonatomic , strong) UILabel *comSendNum;

@property (nonatomic , strong) UIButton *publicBtn;
@property (nonatomic , strong) UIButton *praiteBtn;
@property (nonatomic , copy) NSString *publicityType;
@property (nonatomic , strong) MoneyContent *moneyCt;

@property (nonatomic , strong)NSArray *sectionName;
@property (nonatomic , strong)NSArray *contentArr;

@property (nonatomic,strong)Object *objec;
@property (nonatomic , strong) Result *results;
@property (nonatomic , assign) NSInteger scrollNum;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation ForMoeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找资金";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.sectionName = @[@"投资要求概述",@"投资案例",@"其他备注"];
    self.currentPage = 1;
    _cellNumArr = [NSMutableArray array];
    
    _flag = malloc(sizeof(BOOL)*self.sectionName.count);
    
    memset(_flag, NO, sizeof(BOOL)*self.sectionName.count);
    self.hud = [common createHud];
    [self requestInformation];
}
- (void)requestInformation
{
    [self.hud show:YES];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ZHAOZIJINXIANGQING params:@{@"id":self.moneyCont.zijinID} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                MoneyContent *mone = [MoneyContent objectWithKeyValues:result[@"obj"]];
                weakSelf.moneyCt = mone;
                self.contentArr =@[mone.investmentOverview? mone.investmentOverview:@"",mone.investmentCase? mone.investmentCase:@"",mone.remark? mone.remark:@"",@""];
                
            }
            [self initView];
            [self headerRefreshing];
            MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
            comTableView.header = refreshHeader;
            
            MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
            comTableView.footer = refreshFooter;
            NSMutableString *result = [NSMutableString string];
            for (InvestmentTradeList *inves in self.moneyCt.investmentTradeList)
            {
                [result appendFormat:@"%@ ",inves.name];
            }
            self.guildConLab.text = result;
        }
        [weakSelf.hud hide:YES];
    }];
    
    /**
     *  获取留言列表
     */
//    [self loadNoteList];
}
- (void)initView
{
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_w, 50)];
    titleView.backgroundColor = [UIColor whiteColor];

    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.mj_w - 120, 30)];
    titleLab.text = [NSString stringWithFormat:@"项目方投递项目共计%d次",self.moneyCt.deliveryNumber];
    titleLab.textColor = GREENCOLOR;
    titleLab.font = [UIFont systemFontOfSize:15.0];
    self.titleLab = titleLab;
    [titleView addSubview:titleLab];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [postBtn setFrame:CGRectMake(titleLab.mj_w + titleLab.mj_x + 10, titleLab.mj_y, 80, 30)];
    [postBtn setTitle:@"投递项目" forState:UIControlStateNormal];
    postBtn.layer.masksToBounds = YES;
    postBtn.layer.cornerRadius = 4;
    postBtn.layer.borderWidth = 1;
    postBtn.tintColor = GREENCOLOR;
    postBtn.layer.borderColor = GREENCOLOR.CGColor;
    postBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [postBtn addTarget:self action:@selector(deliverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.postBtn = postBtn;
    [titleView addSubview:postBtn];
    
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleView.mj_h + titleView.mj_y + 10, self.view.mj_w, self.view.mj_h - titleView.mj_h - titleView.mj_y - 10)];
    sc.backgroundColor = [UIColor whiteColor];
    
    UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, 80)];
    sectionView.backgroundColor = [UIColor whiteColor];

    
    UILabel *sectionLab = [[UILabel alloc]init];
    sectionLab.font = [UIFont systemFontOfSize:17.0];
    sectionLab.numberOfLines = 0;
    sectionLab.text = self.moneyCt.title;
    
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.sectionLab.font,NSFontAttributeName,nil];
    CGSize  actualsize =[sectionLab.text boundingRectWithSize:CGSizeMake(130.0f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    sectionLab.frame = CGRectMake(10, 10, self.view.mj_w - 20, actualsize.height);
    self.sectionLab = sectionLab;
    [sectionView addSubview:sectionLab];
    
    UIImageView *dateIm = [[UIImageView alloc]initWithFrame:CGRectMake(10, sectionLab.mj_y + sectionLab.mj_h + 20, 15, 15)];
     dateIm.image = [UIImage imageNamed:@"clock"];
    
    self.dateIm = dateIm;
    [sectionView addSubview:dateIm];
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(dateIm.mj_x + dateIm.mj_w, dateIm.mj_y - 3, self.view.mj_w/2-20, 20)];
    if (self.moneyCt.shelfDate==0.000000) {
        dateLab.text =@"";
    }else
    {
        NSString *sj = [common sectionStrByCreateTime:self.moneyCt.shelfDate];
        dateLab.text = [NSString stringWithFormat:@"更新时间: %@",sj];
    }
    dateLab.font = [UIFont systemFontOfSize:12.0];
    dateLab.textColor = [UIColor grayColor];
    
    self.dateLab = dateLab;
    [sectionView addSubview:dateLab];
    
    UIImageView *lookIm = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-130, dateIm.mj_y, 25, 15)];
    lookIm.image = [UIImage imageNamed:@"a-16"];
    
    self.lookIm = lookIm;
    [sectionView addSubview:lookIm];
    
    UILabel *lookLab = [[UILabel alloc]initWithFrame:CGRectMake([lookIm right]+5, dateIm.mj_y - 2, 100, 20)];
    lookLab.font = [UIFont systemFontOfSize:12.0];
    lookLab.textColor = [UIColor grayColor];
    lookLab.text = [NSString stringWithFormat:@"浏览: %d",self.moneyCt.clickRate];
    self.lookLab = lookLab;
    [sectionView addSubview:lookLab];
    
    UILabel *lookConLab = [[UILabel alloc]initWithFrame:CGRectMake(lookLab.mj_x + lookLab.mj_w, dateIm.mj_y, self.view.mj_w - lookLab.mj_x + lookLab.mj_w - 10, 20)];
    lookConLab.textColor = [UIColor grayColor];
    lookConLab.font = [UIFont systemFontOfSize:12.0];
    [sectionView addSubview:lookConLab];
    
    self.lookConLab = lookConLab;
    self.sectionView = sectionView;
    [sc addSubview:sectionView];
    
    //************** 详情 ******************************
    
    self.detailView = [UIView new];
    
    UILabel *monMainLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    monMainLab.text = @"资金主体：";
    monMainLab.font = [UIFont systemFontOfSize:14.0];
    monMainLab.textColor = COMColor(51, 51, 51, 1.0);
    monMainLab.textAlignment = NSTextAlignmentLeft;
    self.monMainLab = monMainLab;
    
    UILabel *monMainConLab = [[UILabel alloc]initWithFrame:CGRectMake([monMainLab right], 0, self.view.mj_w - monMainLab.frame.size.width -10, 30)];
    monMainConLab.font = [UIFont systemFontOfSize:14.0];
    monMainConLab.textColor = COMColor(51, 51, 51, 1.0);
    monMainConLab.textAlignment = NSTextAlignmentLeft;
//    monMainConLab.text = self.moneyCt.
    self.monMainConLab = monMainConLab;
    
    [self.detailView  addSubview:monMainLab];
    [self.detailView  addSubview:monMainConLab];
    
    // 手机:
    UILabel *guildLab = [[UILabel alloc]initWithFrame:CGRectMake(20, monMainConLab.mj_h + monMainConLab.mj_y , 70, 30)];
    guildLab.text = @"投资行业：";
    guildLab.font = [UIFont systemFontOfSize:14.0];
    guildLab.textColor = COMColor(51, 51, 51, 1.0);
    guildLab.textAlignment = NSTextAlignmentRight;
    self.guildLab = guildLab;
    
    UILabel *guildConLab = [[UILabel alloc]initWithFrame:CGRectMake([guildLab right], monMainConLab.mj_h + monMainConLab.mj_y, self.view.mj_w - monMainLab.frame.size.width -10, 30)];
    guildConLab.font = [UIFont systemFontOfSize:14.0];
    guildConLab.textColor = COMColor(51, 51, 51, 1.0);
    guildConLab.textAlignment = NSTextAlignmentLeft;
    self.guildConLab = guildConLab;
    [self.detailView  addSubview:guildLab];
    [self.detailView  addSubview:guildConLab];
    
    UILabel *amountLab = [[UILabel alloc]initWithFrame:CGRectMake(20, guildConLab.mj_h + guildConLab.mj_y, 70, 30)];
    amountLab.text = @"投资金额：";
    amountLab.font = [UIFont systemFontOfSize:14.0];
    amountLab.textColor = COMColor(51, 51, 51, 1.0);
    amountLab.textAlignment = NSTextAlignmentRight;
    self.amountLab = amountLab;
    
    UILabel *amountConLab = [[UILabel alloc]initWithFrame:CGRectMake([amountLab right],  guildConLab.mj_h + guildConLab.mj_y, self.view.mj_w - monMainLab.frame.size.width -10, 30)];
    amountConLab.font = [UIFont systemFontOfSize:14.0];
    amountConLab.textColor = COMColor(51, 51, 51, 1.0);
    amountConLab.textAlignment = NSTextAlignmentLeft;
    amountConLab.text = [NSString stringWithFormat:@"%d万",self.moneyCt.investmentAmount];
    self.amountConLab = amountConLab;
    
    [self.detailView  addSubview:amountLab];
    [self.detailView  addSubview:amountConLab];
    
    UILabel *dataLab = [[UILabel alloc]initWithFrame:CGRectMake(20, amountConLab.mj_h + amountConLab.mj_y, 100, 30)];
    dataLab.text = @"需要提供资料：";
    dataLab.font = [UIFont systemFontOfSize:14.0];
    dataLab.textColor = COMColor(51, 51, 51, 1.0);
    dataLab.textAlignment = NSTextAlignmentLeft;
    self.dataLab = dataLab;
    
    UILabel *dataConLab = [[UILabel alloc]initWithFrame:CGRectMake([dataLab right],  amountConLab.mj_h + amountConLab.mj_y, self.view.mj_w - dataLab.frame.size.width -10, 30)];
    dataConLab.font = [UIFont systemFontOfSize:14.0];
    dataConLab.textColor = COMColor(51, 51, 51, 1.0);
    dataConLab.textAlignment = NSTextAlignmentLeft;
    if (self.moneyCt.needDataList.count!=0) {
        NeedDataList *need = self.moneyCt.needDataList[0];
        dataConLab.text =need.name;
    }
       self.dataConLab = dataConLab;
    
    [self.detailView  addSubview:dataLab];
    [self.detailView  addSubview:dataConLab];
    //简要说明:
    UILabel *areaLab = [[UILabel alloc]initWithFrame:CGRectMake(20, dataConLab.mj_h + dataConLab.mj_y, 70, 30)];
    areaLab.text = @"所在地区：";
    areaLab.font = [UIFont systemFontOfSize:14.0];
    areaLab.textColor = COMColor(51, 51, 51, 1.0);
    areaLab.textAlignment = NSTextAlignmentRight;
    self.areaLab = areaLab;
    
    UILabel *areaConLab = [[UILabel alloc]initWithFrame:CGRectMake([areaLab right], dataConLab.mj_h + dataConLab.mj_y, 70, 30)];
    areaConLab.font = [UIFont systemFontOfSize:14.0];
    areaConLab.textColor = COMColor(51, 51, 51, 1.0);
    areaConLab.textAlignment = NSTextAlignmentLeft;
    areaConLab.text = self.moneyCt.areaName;
    self.areaConLab = areaConLab;
    
    [self.detailView  addSubview:areaLab];
    [self.detailView  addSubview:areaConLab];
    
    UILabel *placeLab = [[UILabel alloc]initWithFrame:CGRectMake(20, areaConLab.mj_h + areaConLab.mj_y, 70, 30)];
    placeLab.text = @"投资地区：";
    placeLab.font = [UIFont systemFontOfSize:14.0];
    placeLab.textColor = COMColor(51, 51, 51, 1.0);
    placeLab.textAlignment = NSTextAlignmentRight;
    self.placeLab = placeLab;
    
    UILabel *placeConLab = [[UILabel alloc]initWithFrame:CGRectMake([placeLab right], areaConLab.mj_h + areaConLab.mj_y, 70, 30)];
    placeConLab.font = [UIFont systemFontOfSize:14.0];
    placeConLab.textColor = COMColor(51, 51, 51, 1.0);
    placeConLab.textAlignment = NSTextAlignmentLeft;
    NSDictionary *diction = self.moneyCt.investmentAreaList[0];
    placeConLab.text = diction[@"name"];
    self.placeConLab = placeConLab;
    
    [self.detailView  addSubview:placeLab];
    [self.detailView  addSubview:placeConLab];
    
    UILabel *costLab = [[UILabel alloc]initWithFrame:CGRectMake(20, placeConLab.mj_h + placeConLab.mj_y, 70, 30)];
    costLab.text = @"前期费用：";
    costLab.font = [UIFont systemFontOfSize:14.0];
    costLab.textColor = COMColor(51, 51, 51, 1.0);
    costLab.textAlignment = NSTextAlignmentRight;
    self.costLab = costLab;
    [self.detailView  addSubview:costLab];
    
    UILabel *costConLab = [[UILabel alloc]initWithFrame:CGRectMake([costLab right],  placeConLab.mj_h + placeConLab.mj_y, self.view.mj_w - costLab.mj_w -10, 30)];
    costConLab.font = [UIFont systemFontOfSize:14.0];
    costConLab.textColor = COMColor(51, 51, 51, 1.0);
    costConLab.textAlignment = NSTextAlignmentLeft;
    costConLab.text = [NSString stringWithFormat:@"%@万",[common checkStrValue:self.moneyCt.upfrontCostAmount]];
    self.costConLab = costConLab;
    [self.detailView  addSubview:costConLab];
    
    tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.frame = CGRectMake(0, [costConLab bottom]+30, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    tableview.backgroundColor =[UIColor whiteColor];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.detailView addSubview:tableview];
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
    [publicBtn setFrame:CGRectMake(self.view.mj_w - 240, sendBtn.mj_y, 30, 30)];
    [publicBtn addTarget:self action:@selector(publicBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.publicBtn = publicBtn;
    
    self.publicityType = @"0";
    [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"note2"] forState:UIControlStateNormal];
    [self.praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    
    UILabel *publicLab = [[UILabel alloc]initWithFrame:CGRectMake(publicBtn.mj_x + publicBtn.mj_w, publicBtn.mj_y, 40, 30)];
    publicLab.text = @"公开";
    
    [commentView addSubview:publicBtn];
    [commentView addSubview:publicLab];
    
    UIButton *praiteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [praiteBtn setBackgroundImage:[UIImage imageNamed:@"note1"] forState:UIControlStateNormal];
    [praiteBtn setFrame:CGRectMake(publicLab.mj_x + publicLab.mj_w+ 10, sendBtn.mj_y, 30, 30)];
    [praiteBtn addTarget:self action:@selector(praiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.praiteBtn = praiteBtn;
    
    UILabel *praiteLab = [[UILabel alloc]initWithFrame:CGRectMake(praiteBtn.mj_x + praiteBtn.mj_w, publicBtn.mj_y, 40, 30)];
    praiteLab.text = @"私密";
    
    [commentView addSubview:praiteBtn];
    [commentView addSubview:praiteLab];
    
    self.commentView = commentView;
    [self.notesView addSubview:commentView];
    
    UIView *grayView11 = [[UIView alloc]initWithFrame:CGRectMake(0, commentView.mj_y + commentView.mj_h, self.view.mj_w, 5)];
    grayView11.backgroundColor = GRAYCOLOR;
    [self.notesView addSubview:grayView11];
    
    UIView *NotesectionView = [[UIView alloc]initWithFrame:CGRectMake(0, self.commentView.mj_y + self.commentView.mj_h + 10, self.view.mj_w, 50)];
    NotesectionView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *commentNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 70, 40)];
    commentNum.text = @"全部留言";
    self.commentNum = commentNum;
    [NotesectionView addSubview:commentNum];
    // 点赞
//    UIButton *prasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [prasBtn setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
//    prasBtn.frame = CGRectMake(self.view.mj_w - 200, 15, 20, 20);
//    self.prasBtn = prasBtn;
//    
//    UILabel *prasNum = [[UILabel alloc]initWithFrame:CGRectMake(self.prasBtn.mj_x + self.prasBtn.mj_w, 5, 70, 40)];
//    self.prasNum = prasNum;
    // 评论
    UIButton *comSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comSendBtn.frame = CGRectMake(DEF_SCREEN_WIDTH-100, 10, 30, 30);
    [comSendBtn setBackgroundImage:[UIImage imageNamed:@"common"] forState:UIControlStateNormal];
    self.comSendBtn = comSendBtn;
    UILabel *comSendNum = [[UILabel alloc]initWithFrame:CGRectMake( self.comSendBtn.mj_w + self.comSendBtn.mj_x, 5, self.view.mj_w - self.comSendBtn.mj_w - self.comSendBtn.mj_x - 10, 40)];
    comSendNum.text = self.results.totalElements;
    self.comSendNum = comSendNum;
    
//    [NotesectionView addSubview:prasBtn];
//    [NotesectionView addSubview:prasNum];
    [NotesectionView addSubview:comSendBtn];
    [NotesectionView addSubview:comSendNum];
    self.NotesectionView = NotesectionView;
    [self.notesView addSubview:NotesectionView];
    
    comTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sectionView.mj_h + sectionView.mj_y + NotesectionView.mj_h+10, self.view.mj_w, self.view.bounds.size.height/2-25) style:UITableViewStylePlain];
    comTableView.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    comTableView.dataSource = self;
    comTableView.delegate  = self;
    comTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [comTableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [self.notesView addSubview:comTableView];


    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    
    label1.text = @"详情";
    label2.text = @"留言";
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    
    UIView *grayView1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.sectionView.mj_h + self.sectionView.mj_y , self.view.mj_w, 5)];
    grayView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [sc addSubview:grayView1];
    
    self.wjScroll = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, self.sectionView.mj_h + self.sectionView.mj_y + 20, CGRectGetWidth(self.view.bounds), self.view.height + 10) itemArray:@[label1,label2] contentArray:@[self.detailView,self.notesView]];
    self.wjScroll.delegate = self;
    [sc addSubview:self.wjScroll];
    
    UIView *grayView12 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.mj_w, 5)];
    grayView12.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.wjScroll addSubview:grayView12];
    sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + 150);
    
    self.sc = sc;
    [self.view addSubview:sc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.scrollNum == 1)
    {
        //        return comDateModelArr.count;
        return self.results.content.count;
    }
    else
    {
        
        if (_flag[section] == YES) {
            return 1;
        }else{
            return 0;
        }
    }
}
//自定义sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.scrollNum == 1)
    {
        return nil;
    }
    else
    {
        
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
        [button setTitleColor:COMColor(51, 51, 51, 1.0) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 40);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, button.mj_w-110);
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-50,button.mj_h/3, button.mj_h/3+5, button.mj_h/3-5)];
        image.image = [UIImage imageNamed:@"down"];
        image.tag = 10086;
        [head addSubview:image];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.frame = CGRectMake(20, [button bottom]-2, DEF_SCREEN_WIDTH-40, 1);
        [head addSubview:lineView];
        [head addSubview:button];
        
        
        return head;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.scrollNum == 1)
    {
        return 0;
    }
    return 40;
}

- (void)headerButtonClick:(UIButton *)sender{
    int index = (int)[self.sectionName indexOfObject:sender.currentTitle];
//    UIImageView *img = (UIImageView *)[self.view viewWithTag:10086];
//    img.transform = CGAffineTransformMakeRotation(M_PI);
    _flag[index] = !_flag[index];
    
    //动画重载某个区
    [tableview reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollNum == 1){
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
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.text = self.contentArr[indexPath.section];
        
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.scrollNum == 1){
        return 1;
    }
    else
    {
        return self.sectionName.count;
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
    NSString *str = self.contentArr[indexPath.section];
    CGSize size = STRING_SIZE_FONT_HEIGHT(DEF_SCREEN_WIDTH-40, str, 15);
    return size.height+40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)deliverBtnClick:(UIButton *)sender
{
    DeliveryViewController *deliVC = [[DeliveryViewController alloc] init];
    deliVC.zijinId = self.moneyCt.zijinID;
    [self.navigationController pushViewController:deliVC animated:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - UIButton Select Action
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

- (void)sendBtnAction
{
    self.sendBtn.enabled = NO;
    if ([self.commentText.text isEqualToString:@""]) {
        showAlertView(@"留言内容不能为空");
        self.sendBtn.enabled = YES;
        return ;
    }
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEF_ADDNOTES params:@{@"receiverId":@(self.moneyCont.createBy),@"publicityType":self.publicityType,@"content":self.commentText.text,@"businessId":self.moneyCont.zijinID,@"categoryId":@"15"} complete:^(BOOL successed, NSDictionary *result) {
        //
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"10000"]) {
                [weakSelf headerRefreshing];
                weakSelf.commentText.text = @"";
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
#pragma mark- 头部刷新 和 尾部刷新
- (void)headerRefreshing
{
    self.currentPage = 1;
    [comTableView.footer resetNoMoreData];
    WEAKSELF;
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.moneyCont.zijinID,@"categoryId":@"15",@"pageNumber": @(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
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
    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.moneyCont.zijinID,@"categoryId":@"15",@"pageNumber":@(self.currentPage),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed)
        {
            if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
            {
                [comTableView.header endRefreshing];
                Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
                weakSelf.results = resul;
                self.comSendNum.text = resul.totalElements;
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
//    [[HttpManager defaultManager] postRequestToUrl:DEFPROJECTNOTE params:@{@"businessId":self.moneyCont.zijinID,@"categoryId":@"15",@"pageNumber": @(1),@"pageSize": @(10)} complete:^(BOOL successed, NSDictionary *result) {
//        if (successed)
//        {
//            Result *resul = [Result objectWithKeyValues:[result objectForKey:@"lists"] ];
//            //            NSLog(@"%@",result);
//            weakSelf.results = resul;
//            [comTableView reloadData];
//            
//        }
//    }];
//    
//}

- (void)loadWJSliderViewDidIndex:(NSInteger)index
{
    self.scrollNum = index;
    if (self.scrollNum == 1)
    {
        self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y - 130);
        [comTableView reloadData];
    }
    
    else
    {
        self.sc.contentSize = CGSizeMake(0,self.wjScroll.mj_h + self.wjScroll.mj_y + 150);
        [tableview reloadData];
        
    }
}

#pragma mark - textField Delegate

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
