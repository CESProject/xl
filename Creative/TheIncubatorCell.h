//
//  TheIncubatorCell.h
//  Creative
//
//  Created by huahongbo on 16/3/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheIncubatorCell : UICollectionViewCell
{
    UIImageView *img;
    UILabel *nameLab;
}
- (void)setCellWithArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath;
@end
