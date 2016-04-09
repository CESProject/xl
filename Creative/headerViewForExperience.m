//
//  headerViewForExperience.m
//  Creative
//
//  Created by MacBook on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "headerViewForExperience.h"

#define RGBcolor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
@implementation headerViewForExperience


- (instancetype)initWithFrame:(CGRect)frame taget:(id)target action:(SEL)action{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, self.frame.size.height / 2)];
        _lowView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lowView];
        
        self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lowView.frame.size.height + 2, DEF_SCREEN_WIDTH, self.frame.size.height / 2  / 3 * 2)];
        [self addSubview:self.secondView];
        self.secondView.backgroundColor = [UIColor whiteColor];
        [self prictLabel];
        
        self.thiredView = [[UIView alloc]initWithFrame:CGRectMake(0, self.secondView.frame.size.height + self.secondView.frame.origin.y + 2, DEF_SCREEN_WIDTH, self.frame.size.height / 6)];
        self.thiredView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thiredView];
        
        
        
        [self imageViewForI];
        [self TitleLabelI:_lowView];
        [self participant:_lowView];
        [self attentionLabel:_lowView];
        self.backgroundColor = RGBcolor(211, 211, 211);
        [self refundButton:_lowView addTarget:target action:action];
        [self IwantToPrice];
    }
    return self;
}


- (void)imageViewForI{
    
    _imageViewForImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (DEF_SCREEN_WIDTH - 20) / 4, _lowView.frame.size.height / 10 * 9)];
    _imageViewForImage.backgroundColor = [UIColor grayColor];
    [self addSubview:_imageViewForImage];
    
}

- (void)TitleLabelI:(UIView *)lowView{
    
    self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageViewForImage.frame.size.width + 20, self.imageViewForImage.frame.origin.y - 5, 0, 0)];
    self.TitleLabel.numberOfLines = 0;
    self.TitleLabel.font = [UIFont systemFontOfSize:18];
    self.TitleLabel.textColor = RGBcolor(128, 138, 135);
    [lowView addSubview:self.TitleLabel];
    
}

- (void)participant:(UIView *)lowView{
    self.participantLabel = [[LabelAndTextField alloc]initWithFrame:CGRectMake(self.imageViewForImage.frame.size.width + 20, lowView.frame.size.height / 2 , lowView.frame.size.width / 4, lowView.frame.size.height / 6)];
    self.participantLabel.label.text = @"参与者";
    [lowView addSubview:self.participantLabel];
}

- (void)attentionLabel:(UIView *)lowView{
    self.attentionLabel = [[LabelAndTextField alloc]initWithFrame:CGRectMake(self.participantLabel.frame.size.width + self.participantLabel.frame.origin.x + 10, lowView.frame.size.height / 2,  lowView.frame.size.width / 4, lowView.frame.size.height / 6)];
    self.attentionLabel.label.text = @"关注者";
    [lowView addSubview:self.attentionLabel];
    
}

- (void)refundButton:(UIView *)lowView addTarget:(id)target action:(SEL)action{
    self.refundButton = [[UILabel alloc]initWithFrame:CGRectMake(self.attentionLabel.frame.origin.x + self.attentionLabel.frame.size.width - 10  , self.attentionLabel.frame.origin.y + self.attentionLabel.frame.size.height + 10, DEF_SCREEN_WIDTH / 5, lowView.frame.size.height / 5)];
    self.refundButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self.refundButton addGestureRecognizer:tapGesture];
    self.refundButton.textAlignment = NSTextAlignmentCenter;
    self.refundButton.text = @"退款";
    self.refundButton.layer.borderWidth = 1;
    self.refundButton.font = [UIFont boldSystemFontOfSize:18];
    self.refundButton.layer.borderColor = [[UIColor greenColor] CGColor];
    self.refundButton.textColor = RGBcolor(78, 238, 148);
    
//    [self.refundButton addTarget:target action:action forControlEvents:(UIControlEventTouchDragInside)];
//    [self.refundButton setTitle:@"退款" forState:(UIControlStateNormal)];
//    
//    self.refundButton.layer.borderWidth = 2;
//    self.refundButton.layer.borderColor = (__bridge CGColorRef _Nullable)RGBcolor(78, 238, 148);
//    self.refundButton.titleLabel.textColor = RGBcolor(78, 238, 148);
//    [self.refundButton setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
//    [self.refundButton setFont:[UIFont boldSystemFontOfSize:18]];
//    self.refundButton.backgroundColor = [UIColor yellowColor];
    [lowView addSubview:self.refundButton];
    
}
- (void)prictLabel{
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, DEF_SCREEN_WIDTH / 4, self.secondView.frame.size.height / 3)];
    self.priceLabel.text = @"当前价格 :";
    self.priceLabel.textColor = RGBcolor(100, 100, 100);
    self.pricetext = [[UITextField alloc]initWithFrame:CGRectMake(self.priceLabel.frame.size.width + 5, 0, DEF_SCREEN_WIDTH - self.priceLabel.frame.size.width - 15, self.secondView.frame.size.height / 3)];
    self.pricetext.font = [UIFont boldSystemFontOfSize:18];
    self.pricetext.textColor = RGBcolor(255, 127, 36);
    self.pricetext.textAlignment = NSTextAlignmentRight;
    [self.secondView addSubview:self.priceLabel];
    [self.secondView addSubview:self.pricetext];
    
    self.restlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.secondView.frame.size.height / 3, DEF_SCREEN_WIDTH / 4, self.secondView.frame.size.height / 3)];
    self.restlabel.text = @"剩余时间 :";
    self.restlabel.textColor = RGBcolor(100, 100, 100);
   
    self.restltext = [[UIView alloc]initWithFrame:CGRectMake(self.priceLabel.frame.size.width + 5, self.secondView.frame.size.height / 3, DEF_SCREEN_WIDTH - self.priceLabel.frame.size.width - 15, self.secondView.frame.size.height / 3)];
    self.showTimeView = [[TheViewUsedToShowTime alloc]initWithFrame:CGRectMake(self.restltext.frame.size.width/2 - 20, 0 , DEF_SCREEN_WIDTH / 3 + 20 ,self.restltext.frame.size.height) Boold:YES];
    [self.restltext addSubview:self.showTimeView];
    
    [self.secondView addSubview:self.restlabel];
    [self.secondView addSubview:self.restltext];
    

    
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.secondView.frame.size.height / 3 * 2, DEF_SCREEN_WIDTH / 4, self.secondView.frame.size.height / 3)];
    self.currentLabel.text = @"当前领先 :";
    self.currentLabel.textColor = RGBcolor(100, 100, 100);
    self.currenttext = [[UITextField alloc]initWithFrame:CGRectMake(self.priceLabel.frame.size.width + 5, self.secondView.frame.size.height / 3 * 2, DEF_SCREEN_WIDTH - self.priceLabel.frame.size.width - 15, self.secondView.frame.size.height / 3)];
    [self.secondView addSubview:self.currentLabel];
    [self.secondView addSubview:self.currenttext];
    
   

}

- (void)IwantToPrice{
    self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, DEF_SCREEN_WIDTH / 5, self.thiredView.frame.size.height / 3)];
    self.myLabel.text = @"我要出价";
    self.myLabel.font = [UIFont systemFontOfSize:14];
    self.myLabel.textColor = RGBcolor(190, 190, 190);
    [self.thiredView addSubview:self.myLabel];
    
    for (int i = 0; i < 4; i ++) {
        UILabel *iamgeViewe = [[UILabel alloc]initWithFrame:CGRectMake(10 + DEF_SCREEN_WIDTH / 4 * i, self.myLabel.frame.size.height + self.myLabel.frame.origin.y + 3, DEF_SCREEN_WIDTH / 6, self.thiredView.frame.size.height / 3 + 7)];
        iamgeViewe.backgroundColor = [UIColor whiteColor];
        iamgeViewe.textAlignment = UITextAlignmentCenter;
        iamgeViewe.textColor = RGBcolor(255, 127, 80);
        iamgeViewe.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.thiredView addSubview:iamgeViewe];
        switch (i) {
            case 0:
            {
                iamgeViewe.text = @"$ 10";
                iamgeViewe.layer.borderWidth = 1;

            }
                break;
            case 1:
                 iamgeViewe.text = @"$ 100";
                iamgeViewe.layer.borderWidth = 1;

                break;
            case 2:
                 iamgeViewe.text = @"$ 300";
                iamgeViewe.layer.borderWidth = 1;

                break;
            case 3:
                iamgeViewe.text = @"$ 700";
                iamgeViewe.layer.borderWidth = 1;

                break;
                
            default:
                break;
        }
        
    }
    
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 70);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setListFriend:(ListFriend *)listFriend{
    if (_listFriend != listFriend) {
        _listFriend = listFriend;
        CGSize titleCGSize = [self sizeWithText:listFriend.title font:[UIFont systemFontOfSize:18] maxW:DEF_SCREEN_WIDTH / 3 * 2];
       self.TitleLabel.frame = (CGRect){{self.imageViewForImage.frame.size.width + 20, self.imageViewForImage.frame.origin.y },titleCGSize};
        self.pricetext.text = listFriend.currentPrice;
        self.TitleLabel.text = listFriend.title;
        [self.imageViewForImage sd_setImageWithURL:[NSURL URLWithString:listFriend.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        
        NSDictionary *myDictionary = [NSDictionary dictionaryWithObject:listFriend.endTime forKey:@"time"];
        
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getTimerFromDate:) userInfo:myDictionary repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            
        }

    }
}
- (void)getTimerFromDate:(NSTimer *)timer{
    
    NSInteger str  = [timer.userInfo[@"time"] integerValue] / 1000;
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:str];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm/ss"];
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDate *today = [NSDate date];//得到当前时间
    
    //用来得到具体的时差
    
    NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dou = [cal components:unitFlags fromDate:today toDate:nd options:0];
    [self maxThreadForUI:dou];
}

- (TheViewUsedToShowTime *)vvvvvvview{
    if (!_vvvvvvview) {
        _vvvvvvview = [[TheViewUsedToShowTime alloc]initWithFrame:CGRectMake(self.restltext.frame.size.width/2 - 20, 0 , DEF_SCREEN_WIDTH / 3 + 20 ,self.restltext.frame.size.height) Boold:NO];
        
    }
    return _vvvvvvview;
}

- (void)maxThreadForUI:(NSDateComponents *)Componets{
    
    NSString *HourString = [NSString stringWithFormat:@"%ld",[Componets hour]];
    NSString *DayString = [NSString stringWithFormat:@"%ld",[Componets day]];
    NSString *SecondString = [NSString stringWithFormat:@"%ld",[Componets second]];
    NSString *MinutesString = [NSString stringWithFormat:@"%ld",[Componets minute]];
    
    if ([MinutesString integerValue] < 0) {
        [self.showTimeView removeFromSuperview];
        [self.restltext addSubview:self.vvvvvvview];
        return;
    }
    [self.vvvvvvview removeFromSuperview];
    [self TextField:HourString tag1:1004 tag2:1005];
    [self TextField:MinutesString tag1:1007 tag2:1008];
    [self TextField:SecondString tag1:1010 tag2:1011];
    
    UITextField *dayTextField1 = [self.showTimeView viewWithTag:1000];
    UITextField *dayTextField2 = [self.showTimeView viewWithTag:1001];
    UITextField *dayTextField3 = [self.showTimeView viewWithTag:1002];
    if (DayString.length == 3) {
        dayTextField3.text = [DayString substringFromIndex:2];
        dayTextField2.text =  [DayString substringWithRange:NSMakeRange(1, 1)];
        dayTextField1.text = [DayString substringToIndex:1];
        
    }else if(DayString.length == 2){
        dayTextField2.text = [DayString substringToIndex:1];
        dayTextField3.text = [DayString substringFromIndex:1];
        dayTextField1.text = @"0";
    }else if (DayString.length == 1){
        dayTextField3.text = DayString;
        dayTextField2.text =  @"0";
        dayTextField1.text = @"0";
        
    }
    
}
- (void)TextField:(NSString *)string tag1:(NSInteger)tag1 tag2:(NSInteger)tag2{
    UITextField *dayTextField1 = [self.showTimeView viewWithTag:tag1];
    UITextField *dayTextField2 = [self.showTimeView viewWithTag:tag2];
    
    if (string.length == 2) {
        dayTextField1.text = [string substringToIndex:1];
        dayTextField2.text = [string substringFromIndex:1];
    }else if(string.length == 1){
        dayTextField1.text = @"0";
        dayTextField2.text = string;
    }else if (string.length == 3){
        
    }
    
}



@end
