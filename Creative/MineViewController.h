//
//  MineViewController.h
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "ListFriend.h"
@interface MineViewController : UIViewController

@property(nonatomic,strong)WJSliderScrollView *wjScroll;
@property(nonatomic,strong)ListFriend *listFriend;
@property(nonatomic,copy)NSString *btnTit;
@property(nonatomic,copy)NSString *imagUrl;
@property (nonatomic , strong) UIButton *addBtn;
@end
