//
//  ActiveDeatailViewController.h
//  Creative
//
//  Created by Mr Wei on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "Result.h"
#import "ListFriend.h"

@interface ActiveDeatailViewController : UIViewController

@property(nonatomic,strong)WJSliderScrollView *wjScroll;
@property(nonatomic,strong)UIView *detalView;
@property(nonatomic,strong)UIView *commentsView;
//@property(nonatomic,strong)UIView *resulsView;
@property(nonatomic,strong)ListFriend *listFriend;

@end
