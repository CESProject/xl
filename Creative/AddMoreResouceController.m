//
//  AddMoreResouceController.m
//  Creative
//
//  Created by Mr Wei on 16/2/3.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "AddMoreResouceController.h"

#define BUTTONWIDTH (DEF_SCREEN_WIDTH-60)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-60)/11

@interface AddMoreResouceController ()
@property(nonatomic,assign)BOOL isSelet;

@property (nonatomic , strong) NSMutableArray *arrName;
@property (nonatomic , strong) NSMutableArray *arrTag;

@end

@implementation AddMoreResouceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEF_RGB_COLOR(222, 222, 222);
    
    //    self.numArray= [[NSMutableArray alloc]initWithObjects:@"互联网",@"移动互联网",@"IT",@"电信及增值",@"传媒娱乐",@"能源",@"医疗健康",@"旅行",@"游戏",@"金融",@"教育",@"房地产",@"物流仓库",@"农林牧渔",@"住宿餐饮",@"商品服务",@"消费品",@"文体艺术",@"加工制造",@"节能环保",@"其他", nil];
    
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(sureSenderAction) withTitle:@"确定"];
    
    self.navigationItem.leftBarButtonItems = @[back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    
    self.arrName = [NSMutableArray array];
    self.arrTag = [NSMutableArray array];
    
    for (int i=0; i<self.numArray.count; i++)
    {
        CGRect frame;
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:self.numArray[i] forState:UIControlStateNormal];//设置title
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        Btn.tag = i;
        frame.size.width = BUTTONWIDTH;//设置按钮坐标及大小
        frame.size.height = BUTTONHEIGHT;
        frame.origin.x = 20 +(i%3)*(BUTTONWIDTH + 10);
        frame.origin.y = 80 +(i/3)*(BUTTONHEIGHT + 10);
        [Btn setFrame:frame];
        Btn.layer.borderColor = [UIColor grayColor].CGColor;
        Btn.layer.borderWidth = 1.0f;
        Btn.layer.cornerRadius = 5;
        Btn.layer.masksToBounds = YES;
        Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn addTarget:self action:@selector(selectBthClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Btn];
    }
    
}


- (void)sureSenderAction
{
    NSDictionary *dic = @{
                          @"nature":self.arrName,
                          @"tags":self.arrTag
                          };
    
    if (self.passVc == 3)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"identyResouceNature" object:nil userInfo:dic];
        
    }
    
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectBthClick:(UIButton *)button
{
    self.isSelet = button.selected;
    if (self.isSelet==NO) {
        
        button.selected = YES;
        self.isSelet = YES;
        [self.arrName addObject:button.titleLabel.text];
        NSString *str = [NSString stringWithFormat:@"%ld",(long)button.tag];
        [self.arrTag addObject:str];
    }else
    {
        button.selected = NO;
        self.isSelet = NO;
        [self.arrName removeObjectAtIndex:button.tag];
        [self.arrTag removeObjectAtIndex:button.tag];
    }

   
    
}
- (void)backClick
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
