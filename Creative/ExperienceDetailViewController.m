//
//  ExperienceDetailViewController.m
//  Creative
//
//  Created by MacBook on 16/3/9.
//  Copyright © 2016年 王文静. All rights reserved.
//

#define RGBcolor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];


#import "ExperienceDetailViewController.h"
#import "headerViewForExperience.h"

@interface ExperienceDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedController;
@property (nonatomic, strong) headerViewForExperience *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cellArray;
@end

@implementation ExperienceDetailViewController

- (NSArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray arrayWithObjects:@"约会主题",@"简介",@"关于我",@"简洁的主题",@"为什么要和我约会", nil];
    }
    return _cellArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(buttonAction) image:@"3 (6)" highImage:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.headerView = [[headerViewForExperience alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT / 2 + 5) taget:self action:@selector(action2)];
    _headerView.listFriend = self.listFriend;
    self.view.backgroundColor = RGBcolor(211, 211, 211);

    [self.view addSubview:self.headerView];
    [self segmentedControlelr];
    [self.view addSubview:self.tableView];
}

- (void)action2{
    
}
- (void)segmentedControlelr{
    self.segmentedController = [[UISegmentedControl alloc]initWithItems:@[@"详情",@"留言"]];
    self.segmentedController.backgroundColor = [UIColor whiteColor];
    self.segmentedController.frame = CGRectMake(0, self.headerView.frame.size.height + 10, DEF_SCREEN_WIDTH, DEF_SCREEN_WIDTH / 8) ;
    self.segmentedController.selectedSegmentIndex = 0;
    self.segmentedController.tintColor = RGBcolor(139, 137, 137);
    [self.segmentedController addTarget:self action:@selector(segmentedControllerAction:) forControlEvents:(UIControlEventValueChanged)];
//    UIFont *font = [UIFont systemFontOfSize:10];
//    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
//                                                           forKey:NSFontAttributeName];
//    [self.segmentedController setTitleTextAttributes:attributes
//                               forState:UIControlStateNormal];
    UIColor *greenColor = [UIColor blackColor];
    NSDictionary *colorAttr = [NSDictionary dictionaryWithObject:greenColor forKey:NSForegroundColorAttributeName];
    [self.segmentedController setTitleTextAttributes:colorAttr forState:UIControlStateNormal];
    
    
    [self.view addSubview:self.segmentedController];
    
}
- (void)segmentedControllerAction:(UISegmentedControl *)segmented{
    switch (segmented.selectedSegmentIndex) {
        case 0:
            [self.view addSubview:self.tableView];
            break;
        case 1:
        {
            UIView *view44 = [[UIView alloc]initWithFrame:CGRectMake(0, self.segmentedController.frame.size.height + self.segmentedController.frame.origin.y + 4, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - self.segmentedController.frame.size.height - self.segmentedController.frame.origin.y - 4 ) ];
            view44.backgroundColor = [UIColor redColor];
            [self.view addSubview:view44];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)buttonAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.segmentedController.frame.size.height + self.segmentedController.frame.origin.y + 4, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - self.segmentedController.frame.size.height - self.segmentedController.frame.origin.y - 4 - 64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = self.tableView.frame.size.height / 4;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
   
    return _tableView;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.cellArray[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:@"3 (6).png"];
    return cell;
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
