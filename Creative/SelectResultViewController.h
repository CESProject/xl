//
//  SelectResultViewController.h
//  Creative
//
//  Created by huahongbo on 16/1/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectResultViewController : UIViewController
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *cellNumArr;
@property(nonatomic,copy)NSString *resUrl;
@end
