//
//  TableViewCell.h
//  Creative
//
//  Created by MacBook on 16/3/10.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListFriend.h"
@class LabelAndTextField;
@class TheViewUsedToShowTime;
@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) ListFriend *listFrienddd;
@property (nonatomic, strong) UIView *lowView;
@property (nonatomic, strong) UIImageView *imageViewForImage;
@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
//@property (nonatomic, strong) UILabel  *currentPriceLabel;
@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) LabelAndTextField *currentPriceLabel;
@property (nonatomic, strong) TheViewUsedToShowTime *showTimeView;
@property (nonatomic, strong) UILabel *AboutMeLabel;
@property (nonatomic, strong) TheViewUsedToShowTime *vvvvvvview;

@property (nonatomic, strong) NSTimer *timer;




@end
