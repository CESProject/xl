//
//  ForMoeDetailViewController.h
//  Creative
//
//  Created by Mr Wei on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "MoneyContent.h"
@interface ForMoeDetailViewController : UIViewController

@property (nonatomic ,strong) WJSliderScrollView *wjScroll;

@property (nonatomic , strong) UIView *detailView; // 详情
@property (nonatomic , strong) UIView *notesView; // 留言
@property (nonatomic , strong) MoneyContent *moneyCont;
@end
