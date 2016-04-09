//
//  PersonalDataViewController.h
//  Creative
//
//  Created by huahongbo on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDataViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@end
