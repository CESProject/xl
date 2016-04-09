//
//  AppearedTableViewCell.m
//  Creative
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "AppearedTableViewCell.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define color(r,g,b)   [UIColor colorWithRed:(r/255.0) green:g/255.0 blue:(b/255.0) alpha:1.0]

@implementation AppearedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [view addSubview:self.TitleImageView];
        [view addSubview:self.TypeTitle];
        [view addSubview:self.TimeTitle];
        [view addSubview:self.TimeImage];
        [view addSubview:self.ContentLable];
        self.backgroundColor = color(231, 231, 231);
    }
    return self;
}

- (UIImageView *)TitleImageView{
    if (!_TitleImageView) {
        _TitleImageView = [[UIImageView alloc] init];
        _TitleImageView.backgroundColor = [UIColor blackColor];
    }
    return _TitleImageView;
}
- (UILabel *)TypeTitle{
    if (!_TypeTitle) {
        _TypeTitle = [[UILabel alloc] init];
        _TypeTitle.textColor  = [UIColor blackColor];
        //_TypeTitle.text = @"医疗治疗主题";
    }
    return _TypeTitle;
}
- (UILabel *)TimeTitle{
    if (!_TimeTitle) {
        _TimeTitle = [[UILabel alloc] init];
        _TimeTitle.textColor = [UIColor grayColor];
        _TimeTitle.font = [UIFont systemFontOfSize:13];
        _TimeTitle.text      = @"2016-05-20 12:33";
    }
    return _TimeTitle;
}

- (UIImageView *)TimeImage{
    if (!_TimeImage) {
        _TimeImage = [[UIImageView alloc] init];
        _TimeImage.backgroundColor = [UIColor redColor];
    }
    return _TimeImage;
}
- (UILabel *)ContentLable{
    if (!_ContentLable) {
        _ContentLable = [[UILabel alloc] init];
        _ContentLable.textColor  = [UIColor blackColor];
        _ContentLable.text = @"内容";
        
    }
    return _ContentLable;
}
- (UIButton *)HeadButton{
    
    if (!_HeadButton) {
        _HeadButton = [[UIButton alloc]init];
        [_HeadButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_HeadButton setImage:[UIImage imageNamed:@"a-4"] forState:UIControlStateNormal];
        [_HeadButton setTitle:@"T_beg" forState:UIControlStateNormal];
        [_HeadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _HeadButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_HeadButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 5, 0, 0)];
        [_HeadButton addTarget:self action:@selector(HeadButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _HeadButton;
    
}
- (UIButton *)CheackButton{
    if (!_CheackButton) {
        _CheackButton = [[UIButton alloc] init];
        [_CheackButton setImage:[UIImage imageNamed:@"a-16"] forState:UIControlStateNormal];
        [_CheackButton setTitle:@"321" forState:UIControlStateNormal];
        [_CheackButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_CheackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _CheackButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_CheackButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 5, 0, 0)];
        [_CheackButton addTarget:self action:@selector(CheckButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _CheackButton;
}
- (UIButton *)RePlayButton{
    if (!_RePlayButton) {
        _RePlayButton = [[UIButton alloc] init];
        [_RePlayButton setImage:[UIImage imageNamed:@"a-15"] forState:UIControlStateNormal];
        [_RePlayButton setTitle:@"111" forState:UIControlStateNormal];
        [_RePlayButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_RePlayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _RePlayButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_RePlayButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 3, 0, 0)];
        [_RePlayButton addTarget:self action:@selector(ReplayButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _RePlayButton;
    
}
- (void)childAutolayout{
    _TitleImageView.frame = CGRectMake(10, 10, 80, 80);
    _TypeTitle.frame      = CGRectMake(CGRectGetMaxX(_TitleImageView.frame) + 10, CGRectGetMinY(_TitleImageView.frame), screenWidth - 100, 30);
    _ContentLable.frame   = CGRectMake(CGRectGetMaxX(_TitleImageView.frame) + 10, CGRectGetMaxY(_TypeTitle.frame), screenWidth - 100, 30);
    _TimeImage.frame       = CGRectMake(CGRectGetMaxX(_TitleImageView.frame) + 10, CGRectGetMaxY(_ContentLable.frame), 20, 20);
    _TimeTitle.frame      = CGRectMake(CGRectGetMaxX(_TimeImage.frame) + 10 , CGRectGetMaxY(_ContentLable.frame), screenWidth - 100 - 40, 20);
    _HeadButton.frame     = CGRectMake(CGRectGetMaxX(_TitleImageView.frame) + 10 , CGRectGetMaxY(_TitleImageView.frame) - 30, 100, 30);
    _CheackButton.frame    = CGRectMake(screenWidth - 180 , CGRectGetMaxY(_TitleImageView.frame) - 30, 60, 30);
    
    _RePlayButton.frame    = CGRectMake(screenWidth - 90 , CGRectGetMaxY(_TitleImageView.frame) - 30, 60, 30);
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self childAutolayout];
}
#pragma mark-buttonAction
- (void)HeadButtonClickAction:(id)sender{
    [self.delegate ClickWithHeadButton:self];
}
- (void)CheckButtonClickAction:(id)sender{
    [self.delegate ClickWithCheackButton:self];
}
- (void)ReplayButtonClickAction:(id)sender{
    [self.delegate ClickWithRePlayButton:self];
}


@end
