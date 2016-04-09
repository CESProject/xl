//
//  LoginViewController.h
//  Creative
//
//  Created by huahongbo on 15/12/29.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *nameTF;
    UITextField *passwordTF;
}
@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@end
