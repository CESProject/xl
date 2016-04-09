//
//  SearchActiviteView.h
//  Creative
//
//  Created by Mr Wei on 16/2/24.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchActiviteDelegate <NSObject>

- (void)passViewControl;

@end

@interface SearchActiviteView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , assign) id<SearchActiviteDelegate>delegate;

@property (nonatomic , strong) UIView *leftView;

@property (nonatomic , strong) UITableView *leftTableView; // fenl
@property(nonatomic,strong)UITableView *mytableview; // 费用
@property(nonatomic,strong)UITableView *timeTableview; // 时间

@property (nonatomic , strong) UIView *areaView;

@property (nonatomic , strong) NSArray *typeArr;  //分类
@property (nonatomic , strong) NSString *typeStr;
@property (nonatomic , strong) NSArray *timeArr;  //时间
@property (nonatomic , strong) NSString *timeStr;
@property (nonatomic , strong) NSArray *isfreeArr;
@property (nonatomic , strong) NSString *freeStr;

@property (nonatomic , strong) UIButton *surerBtn;
@property (nonatomic , strong) UIButton *chaBtn;
@property (nonatomic , strong) UITextField *saveText;
@property (nonatomic , strong) UIButton *saveBtn;

@property (nonatomic , strong) NSMutableArray *selectCityArr;
@property (nonatomic , strong) NSMutableArray *selectCityCodeArr;

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITextField *textField1;

@end
