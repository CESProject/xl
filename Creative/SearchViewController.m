//
//  SearchViewController.m
//  Creative
//
//  Created by huahongbo on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//
#define BUTTONWIDTH (DEF_SCREEN_WIDTH-40)/3
#define BUTTONHEIGHT (DEF_SCREEN_WIDTH-40)/11
#import "SearchViewController.h"
#import "SearchResultsViewController.h"
#import "Result.h"
#import "XMSearchViewController.h"
#import "HDSearchViewController.h"
#import "ZDSViewController.h"
#import "ZZJViewController.h"
#import "ZCDViewController.h"
#import "MoneyModel.h"
#import "searchResultForExperienceController.h"
@interface SearchViewController ()<UISearchBarDelegate>
{
    NSMutableArray *numArr;
    UISearchBar *searchBarr;
}
//@property (nonatomic,retain) UISearchBar* searchBar;
@end

@implementation SearchViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self readNSUserDefaults];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"back"];
    self.navigationItem.leftBarButtonItems = @[back];
    
    searchBarr = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 0, 50, 40)];
    searchBarr.placeholder = @"搜索";
    searchBarr.delegate = self;
    self.navigationItem.titleView = searchBarr;
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 74, DEF_SCREEN_WIDTH-20, 21)];
    label.text=@"历史搜索";
    label.textColor=[UIColor lightGrayColor];
    [self.view addSubview:label];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self SearchText:searchBar.text];
    if ([self.searchUrl isEqualToString:DEF_LUYANSHOUYE])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"name":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    SearchResultsViewController *searchVC = [[SearchResultsViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DEF_XMGJZSEARCH])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"name":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    XMSearchViewController *searchVC = [[XMSearchViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DEF_HDGJZSEARCH])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"theme":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    HDSearchViewController *searchVC = [[HDSearchViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DEF_ZDSGJZSEARCH])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"name":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    ZDSViewController *searchVC = [[ZDSViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DEF_ZZJGJZSEARCH])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"title":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    MoneyModel *data = [MoneyModel objectWithKeyValues:result[@"lists"]];
                    ZZJViewController *searchVC = [[ZZJViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:data.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DEF_ZCDGJZSEARCH])
    {
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"name":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    ZCDViewController *searchVC = [[ZCDViewController alloc] init];
                    searchVC.cellNumArr = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];
    }else if ([self.searchUrl isEqualToString:DER_JIANSUOYUEHUI]){
        WEAKSELF;
        [[HttpManager defaultManager] postRequestToUrl:self.searchUrl params:@{@"title":searchBar.text} complete:^(BOOL successed, NSDictionary *result) {
            if (successed)
            {
                if ([[result objectForKey:@"code"] isEqualToString:@"10000"])
                {
                    Result *dat = [Result objectWithKeyValues:result[@"lists"]];
                    searchResultForExperienceController  *searchVC = [[searchResultForExperienceController alloc] init];
                    searchVC.CellArray = [NSMutableArray arrayWithArray:dat.content];
                    [weakSelf.navigationController pushViewController:searchVC animated:YES];
                }
            }
        }];

    }
}
-(void)SearchText :(NSString *)seaTxt{
    //将你搜索的历史词语保存到本地
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    NSMutableArray *searTXT = [NSMutableArray arrayWithArray:myArray];
    for (NSString *tex in searTXT)
    {
        if ([seaTxt isEqualToString:tex])
        {
            return;
        }
    }
    [searTXT addObject:seaTxt];
    if(searTXT.count > 9) {
        
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"myArray"];
}
-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    [self setbtn:myArray];
}
-(void)setbtn:(NSArray*)arr
{
    for (int i=0; i<arr.count; i++)
    {
        CGRect frame;
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:arr[i] forState:UIControlStateNormal];//设置title
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        Btn.tag = i;
        frame.size.width = BUTTONWIDTH;//设置按钮坐标及大小
        frame.size.height = BUTTONHEIGHT;
        frame.origin.x = 10 +(i%3)*(BUTTONWIDTH + 10);
        frame.origin.y = 100 +(i/3)*(BUTTONHEIGHT + 10);
        [Btn setFrame:frame];
        Btn.layer.borderColor = [UIColor grayColor].CGColor;
        Btn.layer.borderWidth = 1.0f;
        Btn.layer.cornerRadius = 5;
        Btn.layer.masksToBounds = YES;
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn addTarget:self action:@selector(selectBthClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Btn];
    }

}
- (void)selectBthClick:(UIButton *)btn
{
    searchBarr.text = btn.titleLabel.text;
    [searchBarr becomeFirstResponder];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
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
