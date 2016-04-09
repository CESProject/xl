//
//  Model.h
//  Creative
//
//  Created by huahongbo on 15/12/29.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,   copy) NSString *code;
@property(nonatomic,   copy) NSString *userId;
@property(nonatomic,   copy) NSString *loginName;
@property(nonatomic,   copy) NSString *roleList;
@property(nonatomic,   copy) NSString *token;
@property(nonatomic,   copy) NSString *type;




//判断是否为真实手机号码
+ (BOOL)checkInputMobile:(NSString *)_text;
/**
 * 判断邮箱格式是否正确
 */
+ (BOOL) validateEmail:(NSString *)email;

+(BOOL)isLogin;
+(void)setLoginOk;
+(void)cancelLogin;
//+(void)setLogin:(NSString*)userName password:(NSString*)password phonenumber:(NSString*)phonenumber accountid:(NSString*)accountid nickname:(NSString*)nickname uid:(NSString*)uid userid:(NSString*)userid;



+(void)openMainVC;
@end
