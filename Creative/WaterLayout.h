//
//  ViewController.m
//  WaterFlow
//
//  Created by WooY on 15/12/30.
//  Copyright (c) 2015年 WooY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WaterLayoutDelegate<UICollectionViewDelegate>
@required
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface WaterLayout : UICollectionViewLayout

@property(nonatomic,weak)id<WaterLayoutDelegate> delegate;

@end







