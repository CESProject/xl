//
//  RegionViewController.h
//  Creative
//
//  Created by huahongbo on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionViewController : UIViewController

@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic , assign) int passVc; // 2：项目汇  3：表示从资源库导师 4：表示从资源库找资金 // 5：表示从找场地

@end
