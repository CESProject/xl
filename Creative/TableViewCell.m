//
//  TableViewCell.m
//  Creative
//
//  Created by MacBook on 16/3/10.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "TableViewCell.h"
#import "LabelAndTextField.h"
#import "TheViewUsedToShowTime.h"
#define HEIGHT DEF_SCREEN_WIDTH / 3 + DEF_SCREEN_WIDTH /10
#define RGBcolor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];

@implementation TableViewCell

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBcolor(192, 192, 192);
        self.lowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, HEIGHT - 8)];
        self.lowView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lowView];
    
        [self imageViewForI];
        [self TitleLabelI];
        [self addressLabelI];
        [self contentLabelI];
        [self currentPriceLabelI];
        [self TimeForLabel];
        [self aboutMELabel];
        
            }
    return self;
}
- (void)imageViewForI{
    
    _imageViewForImage = [[UIImageView alloc]init];
    _imageViewForImage.center = CGPointMake(0, HEIGHT / 2);
    _imageViewForImage.frame = CGRectMake(10, 10, (DEF_SCREEN_WIDTH - 20) / 4, (HEIGHT - 30));
    [self.lowView addSubview:self.imageViewForImage];
}
- (void)TitleLabelI{
    
    self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageViewForImage.frame.size.width + 20, self.imageViewForImage.frame.origin.y - 8, DEF_SCREEN_WIDTH - self.imageViewForImage.frame.size.width - 20 , self.imageViewForImage.frame.size.height / 4)];
    self.TitleLabel.numberOfLines = 0;
    self.TitleLabel.font = [UIFont systemFontOfSize:18];
    self.TitleLabel.textColor = RGBcolor(128, 138, 135);
    [self.lowView addSubview:self.TitleLabel];
    
}
- (void)addressLabelI{
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageViewForImage.frame.size.width + 20, self.TitleLabel.frame.origin.y + self.TitleLabel.frame.size.height  , DEF_SCREEN_WIDTH / 5, self.imageViewForImage.frame.size.height / 5)];
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textColor = RGBcolor(255, 97, 3);
    [self.lowView addSubview:self.addressLabel];
}
- (void)contentLabelI{
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.addressLabel.frame.size.width + self.addressLabel.frame.origin.x, self.TitleLabel.frame.origin.y + self.TitleLabel.frame.size.height + 4, 0, self.imageViewForImage.frame.size.height / 5)];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = RGBcolor(192, 192, 192);
    [self.lowView addSubview:self.contentLabel];
}
- (void)aboutMELabel{
    self.AboutMeLabel = [[UILabel alloc]init];
    self.AboutMeLabel.numberOfLines = 0;
    self.AboutMeLabel.font = [UIFont systemFontOfSize:13];
    self.AboutMeLabel.textColor = RGBcolor(192, 192, 192);
    [self.lowView addSubview:self.AboutMeLabel];
}
- (void)currentPriceLabelI{

    self.currentPriceLabel = [[LabelAndTextField alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 3 * 2 + 20, self.imageViewForImage.center.y + 20, DEF_SCREEN_WIDTH - DEF_SCREEN_WIDTH / 3 * 2 - 30, 60)];
    [self.lowView addSubview:self.currentPriceLabel];
}

- (void)TimeForLabel{
    self.showTimeView = [[TheViewUsedToShowTime alloc]initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, self.imageViewForImage.center.y + 20, DEF_SCREEN_WIDTH / 3 + 20 , self.imageViewForImage.frame.size.height  / 4) Boold:YES];
    [self.lowView addSubview:self.showTimeView];
    
}


- (void)setListFrienddd:(ListFriend *)listFrienddd{
    if (_listFrienddd != listFrienddd ) {
        
        self.TitleLabel.text = listFrienddd.title;
        self.contentLabel.text = listFrienddd.createName;
        [self.contentLabel sizeToFit];
        WQLog(@"%@=======%@",listFrienddd.aboutMe,listFrienddd.createName)
        self.AboutMeLabel.text = listFrienddd.aboutMe;
        CGSize sizelll = [self sizeWithText:listFrienddd.aboutMe font:[UIFont systemFontOfSize:15] maxW:DEF_SCREEN_WIDTH / 3 * 2];
        self.AboutMeLabel.frame = (CGRect){{self.imageViewForImage.frame.size.width + 20, self.addressLabel.frame.size.height + self.addressLabel.frame.origin.y},sizelll};
       
        
        
        
        self.currentPriceLabel.priceTextField.text = [NSString stringWithFormat:@"$%@",listFrienddd.currentPrice];
        
        self.addressLabel.text = [NSString stringWithFormat:@"[%@]",listFrienddd.cityName];
        [self.imageViewForImage sd_setImageWithURL:[NSURL URLWithString:listFrienddd.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
        
        
        NSDictionary *myDictionary = [NSDictionary dictionaryWithObject:listFrienddd.endTime forKey:@"time"];

        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getTimerFromDate:) userInfo:myDictionary repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

        }
    }
}
#pragma －－－－－－－－－－－－开辟子线程计算时间－－－－－－－－－－

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
       _vvvvvvview = [[TheViewUsedToShowTime alloc]initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, self.imageViewForImage.center.y + 20, DEF_SCREEN_WIDTH / 3 + 20 , self.imageViewForImage.frame.size.height  / 4) Boold:NO];

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
        [self addSubview:self.vvvvvvview];
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



- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 40);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
