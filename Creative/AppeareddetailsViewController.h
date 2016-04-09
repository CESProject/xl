//
//  AppeareddetailsViewController.h
//  Creative
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "ListFriend.h"

@interface AppeareddetailsViewController : UIViewController
@property (nonatomic,strong) WJSliderScrollView *scroll;
@property (nonatomic,strong) UIView *detailView;
@property (nonatomic,strong) UIView *notesView;
@property (nonatomic,strong) ListFriend *listF;
@end
