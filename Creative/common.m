//
//  common.m
//  Creative
//
//  Created by Mr Wei on 15/12/31.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "common.h"
#import <dlfcn.h>
#import <sys/utsname.h>
#import <sys/socket.h>
#import <sys/sysctl.h>

@implementation common

+ (UILabel *)createLabelWithFrame:(CGRect)frame andText:(NSString *)text
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.text = text;
//    lbl.font = [UIFont systemFontOfSize:14.0];
    lbl.textColor = COMColor(51, 51, 51, 1.0);
    lbl.textAlignment = NSTextAlignmentLeft;
    return lbl;
}

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize textSize = [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return textSize;
    
}

+ (MBProgressHUD *)createHud
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[UIApplication sharedApplication].delegate window]];
    hud.dimBackground = NO;
    hud.margin = 10.0;
    hud.removeFromSuperViewOnHide = YES;
    [[[UIApplication sharedApplication].delegate window] addSubview:hud];
    return hud;
}

/**
 * 检测是否为空
 */
+(NSString*)checkStrValue:(NSString*)strValue
{
    if (strValue == nil || (id) strValue == [NSNull null])
    {
        strValue = @" ";
    }
    return strValue;
}
/**
 * 将时间戳转化为时间
 */
+ (NSString *)sectionStrByCreateTime:(NSTimeInterval)interval
{
    static NSDateFormatter *formatter = nil;
    if (nil == formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSDate *_data = [NSDate dateWithTimeIntervalSince1970:(interval / 1000)];
    return [formatter stringFromDate:_data];
}
+(UIWebView *)creatWebViewUrlName:(NSString *)urlString control:(UIViewController *)viewControl frame:(CGRect)frame
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    UIWebView *contentView = [[UIWebView alloc] init];
    contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    contentView.frame =frame;
    [viewControl.view addSubview:contentView];
    [contentView loadRequest:request];
    
    return contentView;
}

/**
 * 计算时间差
 */
//+(NSString *) compareCurrentTime:(NSDate *)compareDate
+(NSString *) compareCurrentTime:(NSTimeInterval)interval
{
    NSDate *_data1 = [NSDate dateWithTimeIntervalSince1970:(interval / 1000)];
    
    NSTimeInterval  timeInterval = [_data1 timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    if (timeInterval - 300 < 60)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = (timeInterval - 300)/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else
    {
        static NSDateFormatter *formatter1 = nil;
        if (nil == formatter1) {
            formatter1 = [[NSDateFormatter alloc] init];
            formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        NSDate *_data = [NSDate dateWithTimeIntervalSince1970:(interval / 1000)];
        result = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:_data]];
    }
    
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    
    return  result;
}
/**
 * 获得设备型号
 */
+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}



@end
