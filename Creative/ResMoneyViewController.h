//
//  ResMoneyViewController.h
//  Creative
//
//  Created by huahongbo on 16/2/1.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
@interface ResMoneyViewController : UIViewController<WJSliderViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) WJSliderScrollView *wjScroll;
@property (nonatomic , strong) UIView *deliveryMonView; // 投递
@property (nonatomic , strong) UIView *releaseMonView; // 发布
@end
