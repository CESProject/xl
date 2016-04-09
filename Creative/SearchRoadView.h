//
//  SearchRoadView.h
//  Creative
//
//  Created by Mr Wei on 16/2/23.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchRoadDelegate <NSObject>

- (void)passViewControl;

@end

@interface SearchRoadView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,assign) id <SearchRoadDelegate>delegate;

@property (nonatomic , strong) UIView *leftView;

@property (nonatomic , strong) UITableView *leftTableView;
@property (nonatomic , strong) UIView *areaView;

@property(nonatomic,strong)UITableView *mytableview;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , strong) NSArray *hangArr;
@property (nonatomic , copy) NSString *hangStr;

@property (nonatomic , strong) UIButton *surerBtn;
@property (nonatomic , strong) UIButton *chaBtn;
@property (nonatomic , strong) UITextField *saveText;
@property (nonatomic , strong) UIButton *saveBtn;

@property (nonatomic , strong) NSMutableArray *selectCityArr;
@property (nonatomic , strong) NSMutableArray *selectCityCodeArr;


@end
