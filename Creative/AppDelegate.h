//
//  AppDelegate.h
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

- (void)openLeftVC:(id)mainVC;
- (void)loginView;
@end

