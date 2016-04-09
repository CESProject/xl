//
//  Model.m
//  Creative
//
//  Created by huahongbo on 15/12/29.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "Model.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@implementation Model
#pragma mark - 判断是否为真实手机号码
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userId": @"id"
             };
}



+ (BOOL)checkInputMobile:(NSString *)_text
{
    //
    NSString *MOBILE    = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM        = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[12378]|7[7])\\d)\\d{7}$";   // 包含电信4G 177号段
    NSString *CU        = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT        = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    //
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:_text];
    BOOL res2 = [regextestcm evaluateWithObject:_text];
    BOOL res3 = [regextestcu evaluateWithObject:_text];
    BOOL res4 = [regextestct evaluateWithObject:_text];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    
    return NO;
}

/**
 * 判断邮箱格式是否正确
 */
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isLogin
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"] == YES){
        return YES;
    }else{
        return NO;
    }
}

+(void)cancelLogin
{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)setLoginOk
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//+(void)setLogin:(NSString*)userName password:(NSString*)password phonenumber:(NSString*)phonenumber accountid:(NSString*)accountid nickname:(NSString*)nickname uid:(NSString*)uid userid:(NSString*)userid
//{
//    
//    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userid"];
//    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
//    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
//    [[NSUserDefaults standardUserDefaults] setObject:phonenumber forKey:@"phonenumber"];
//    [[NSUserDefaults standardUserDefaults] setObject:accountid forKey:@"accountid"];
//    // [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:@"nickname"];
//    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

+(void)openMainVC
{
    AppDelegate *App = [[UIApplication sharedApplication] delegate];
    MainViewController *mainVC = [[MainViewController alloc] init];

    [App openLeftVC:mainVC];
}
@end
