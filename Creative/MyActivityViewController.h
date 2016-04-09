//
//  MyActivityViewController.h
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
@interface MyActivityViewController : UIViewController<WJSliderViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableVIew;
}
@property (nonatomic ,strong) WJSliderScrollView *wjScroll;
@property (nonatomic , strong) UIView *releaseView; // 发布
@property (nonatomic , strong) UIView *participateView; // 参加
@end
