//
//  headerViewForExperience.h
//  Creative
//
//  Created by MacBook on 16/3/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListFriend.h"
#import "LabelAndTextField.h"
#import "TheViewUsedToShowTime.h"
@interface headerViewForExperience : UIView
@property (nonatomic, strong) ListFriend *listFriend;
@property (nonatomic, strong) UIImageView *imageViewForImage;
@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) LabelAndTextField *participantLabel;
@property (nonatomic, strong) LabelAndTextField *attentionLabel;
@property (nonatomic, strong) UILabel *refundButton;
@property (nonatomic, strong) UIView *lowView;
@property (nonatomic, strong) TheViewUsedToShowTime *vvvvvvview;


@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *restlabel;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UITextField *pricetext;
@property (nonatomic, strong) UIView *restltext;
@property (nonatomic, strong) UITextField *currenttext;

@property (nonatomic, strong) UIView *thiredView;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) TheViewUsedToShowTime *showTimeView;


- (instancetype)initWithFrame:(CGRect)frame taget:(id)target action:(SEL)action;




@end
