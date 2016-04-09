//
//  TeacherSearchView.h
//  Creative
//
//  Created by Mr Wei on 16/2/24.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TeacherSearchViewDelegate <NSObject>

- (void)passViewControl;

@end

@interface TeacherSearchView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) id<TeacherSearchViewDelegate>delegate;

@property (nonatomic , strong) UIView *leftView;

@property (nonatomic , strong) UITableView *leftTableView;
@property(nonatomic,strong)UITableView *mytableview;
@property(nonatomic,strong)UITableView *timeTableview;
@property(nonatomic,strong)UITableView *ageTableview;

@property (nonatomic , strong) UIView *areaView;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , strong) NSArray *hangArr;
@property (nonatomic , copy) NSString *hangStr;
@property (nonatomic , strong) NSArray *identityArr;
@property (nonatomic , strong) NSString *identityStr;
@property (nonatomic , strong) NSArray *ageArr;
@property (nonatomic , copy) NSString *ageStr;

@property (nonatomic , strong) UIButton *surerBtn;
@property (nonatomic , strong) UIButton *chaBtn;
@property (nonatomic , strong) UITextField *saveText;
@property (nonatomic , strong) UIButton *saveBtn;

@property (nonatomic , strong) NSMutableArray *selectCityArr;
@property (nonatomic , strong) NSMutableArray *selectCityCodeArr;

@end
