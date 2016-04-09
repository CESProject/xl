//
//  LeftSortsViewController.h
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSortsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *bottonView;
@end
