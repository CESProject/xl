//
//  FlashTableViewCell.h
//  Creative
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewCell;
@protocol TableViewCelldelegate<NSObject>

- (void)ClickWithHeadButton:(TableViewCell *)cell;
- (void)ClickWithCheackButton:(TableViewCell *)cell;
- (void)ClickWithRePlayButton:(TableViewCell *)cell;

@end

@interface FlashTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *TitleImageView;
@property (nonatomic , strong) UILabel     *TypeTitle;
@property (nonatomic , strong) UILabel     *ContentLable;
@property (nonatomic , strong) UILabel     *TimeTitle;
@property (nonatomic , strong) UIImageView *TimeImage;
@property (nonatomic , strong) UIButton    *HeadButton;
@property (nonatomic , strong) UIButton    *CheackButton;
@property (nonatomic , strong) UIButton    *RePlayButton;
@property (assign)id<TableViewCelldelegate>delegate;

@end
