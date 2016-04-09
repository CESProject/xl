//
//  ViewController.m
//  WaterFlow
//
//  Created by WooY on 15/12/30.
//  Copyright (c) 2015年 WooY. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout(){
    //cell的x坐标
    float x;
    //左边一列的坐标
    float leftY;
    //右边一列的坐标
    float rightY;
    //每列cell的宽度
    float itemWidth;
    //cell的数量
    NSInteger cellCount;
    //cell的间隔
    UIEdgeInsets sectionInsets;


}

@end

@implementation WaterLayout

- (void)prepareLayout{
    itemWidth = (DEF_SCREEN_WIDTH*0.7-15)/2;
    sectionInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    cellCount = [[self collectionView] numberOfItemsInSection:0];
    //设置代理
    self.delegate = (id<WaterLayoutDelegate>)self.collectionView.delegate;
    
}
//返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize{
    CGSize size = CGSizeMake(DEF_SCREEN_WIDTH*0.7, leftY>rightY?leftY:rightY);
    
    return size;
}
//返回rect中的所有的元素的布局属性
//返回的是包含UICollectionViewLayoutAttributes的NSArray

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    //显示的可见区域，每次显示新的内容都要重新初始化计算
    x = 0;
    leftY = 0;
    rightY = 0;
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (int i = 0; i<cellCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        
    }

    return attributes;

}

//返回对应于indexPath的位置的cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    CGFloat itemHeight = itemSize.height;
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //long num = indexPath.row+1;
    
    //判断哪一列的高度较低下一个cell就放在哪一列
    
    if (leftY>rightY) {
        
        x = DEF_SCREEN_WIDTH*0.7/2+2;
        
        rightY += sectionInsets.top;
        
        attributes.frame = CGRectMake(x, rightY, itemWidth, itemHeight);
        
        rightY += itemHeight;
        
    }else{
        
        x = sectionInsets.left;
        
        leftY += sectionInsets.top;
        
        attributes.frame = CGRectMake(x, leftY, itemWidth, itemHeight);
        
        leftY += itemHeight;
    
    }

    return attributes;

}

@end
