//
//  common.h
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface common : NSObject

+ (UILabel *)createLabelWithFrame:(CGRect)frame andText:(NSString *)text;
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (MBProgressHUD *)createHud;
/**
 * 检测是否为空
 */
+(NSString*)checkStrValue:(NSString*)strValue;
/**
 * 将时间戳转化为时间
 */
+ (NSString *)sectionStrByCreateTime:(NSTimeInterval)interval;
+(UIWebView *)creatWebViewUrlName:(NSString *)urlString control:(UIViewController *)viewControl frame:(CGRect)frame;
/**
 * 计算时间差
 */
+(NSString *) compareCurrentTime:(NSTimeInterval)interval;

/**
 * 获得设备型号
 */
+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller;


@end
