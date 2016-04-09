//
//  TheViewUsedToShowTime.m
//  Creative
//
//  Created by MacBook on 16/3/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TheViewUsedToShowTime.h"
#define RGBcolor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
#define widthforself self.frame.size.width / 11;


@implementation TheViewUsedToShowTime

- (instancetype)initWithFrame:(CGRect)frame Boold:(BOOL)isYes{
    self = [super initWithFrame:frame];
    if (self) {
        [self removeAllSubviews];
        if (isYes) {
            
       
        for (int i = 0; i < 12; i ++) {
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(i * frame.size.width / 11 - 2, frame.size.height / 2, frame.size.width / 11 - 3, frame.size.height / 2)];
            textField.backgroundColor = [UIColor blackColor];
            textField.textColor = [UIColor whiteColor];
            textField.font = [UIFont systemFontOfSize:13];
                        //设置圆角
            textField.layer.masksToBounds = YES;
            textField.layer.cornerRadius = 4;
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            
            textField.tag = 1000 + i;
                       switch (i) {
                case 3:
                    textField.backgroundColor = [UIColor whiteColor];
                    textField.textColor = [UIColor blackColor];
                               textField.text = @":";
                               textField.textColor = [UIColor blackColor];

                    
                case 6:
                    textField.backgroundColor = [UIColor whiteColor];
                    textField.textColor = [UIColor blackColor];
                               textField.text = @":";
                               textField.textColor = [UIColor blackColor];

                case 9:
                    textField.backgroundColor = [UIColor whiteColor];
                    textField.textColor = [UIColor blackColor];
                               textField.text = @":";
                               textField.textColor = [UIColor blackColor];
                           default:
                               break;
                   
            }
            [self addSubview:textField];
        }
        }else{
            
            for (int i = 0; i < 4; i ++) {
                UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake(i * frame.size.width / 4 + 10, frame.size.height / 2, frame.size.width / 4 - 8, frame.size.height / 2)];
                textField.tag = 2000 + i;
                textField.font = [UIFont systemFontOfSize:13];
                textField.backgroundColor = [UIColor blackColor];
                textField.textColor = [UIColor whiteColor];
                textField.layer.masksToBounds = YES;
                textField.layer.cornerRadius = 4;
                textField.textAlignment = NSTextAlignmentCenter;
                switch (i) {
                    case 0:
                        textField.text = @"竞";
                        break;
                    case 1:
                        textField.text = @"拍";
                        break;
                    case 2:
                        textField.text = @"结";
                        break;
                    case 3:
                        textField.text = @"束";
                        break;
                    default:
                        break;
                }
                [self addSubview:textField];

            }
            
        }
        
        
        [self labelForTime:@"天" cgsize:CGRectMake(frame.size.width / 11 - 2, 0,frame.size.width / 11 * 2,frame.size.height / 2 )];
        [self labelForTime:@"小时" cgsize:CGRectMake(4 * frame.size.width / 11 - 2, 0, frame.size.width / 11 * 2 + 8, frame.size.height / 2)];
        [self labelForTime:@"分" cgsize:CGRectMake(7 * frame.size.width / 11 - 2, 0, self.frame.size.width / 11 * 2, frame.size.height / 2)];
        [self labelForTime:@"秒" cgsize:CGRectMake(10 * frame.size.width / 11 - 2, 0, self.frame.size.width / 11 * 2, frame.size.height / 2)];
    }
    return self;
}


- (void)labelForTime:(NSString *)timeString cgsize:(CGRect)rect{
    
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.text = timeString;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = RGBcolor(192, 192, 192);
    [self addSubview:label];
    
}






@end
