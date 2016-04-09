//
//  SelectViewController.h
//  Creative
//
//  Created by huahongbo on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *numArray;

@property (nonatomic , assign) int passVc; // 2：表示从项目跳转 3：表示从资源库导师 4：表示找资金行业
@end
