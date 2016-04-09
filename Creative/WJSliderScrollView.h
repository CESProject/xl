//
//  WJSliderScrollView.h
//  WJSliderView
//
//  Created by 谭启宏 on 15/12/18.
//  Copyright © 2015年 谭启宏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WJSliderViewDelegate <NSObject>

- (void)loadWJSliderViewDidIndex:(NSInteger)index;

@end

@interface WJSliderScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray<UIView *> *)itemArray contentArray:(NSArray<UIView *>*)contentArray;

@property (nonatomic , weak) id<WJSliderViewDelegate>delegate;

- (void)WJSliderViewDidIndex:(NSInteger)index;

@end
