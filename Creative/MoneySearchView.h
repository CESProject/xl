//
//  MoneySearchView.h
//  Creative
//
//  Created by Mr Wei on 16/2/25.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoneySearchViewDelegate <NSObject>

- (void)passViewControl;

- (void)passViewMorePlaceControlDic:(NSMutableDictionary *)dic andArr:(NSMutableArray *)arr;

@end

@interface MoneySearchView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) id<MoneySearchViewDelegate>delegate;

@property (nonatomic , strong) UIView *leftView;

@property (nonatomic , strong) UITableView *leftTableView;
@property(nonatomic,strong)UITableView *mytableview;
@property(nonatomic,strong)UITableView *timeTableview;
@property(nonatomic,strong)UITableView *ageTableview;
@property(nonatomic,strong)UITableView *moneyTableview;

@property (nonatomic , strong) UIView *areaView;

@property (nonatomic , copy) NSString *placeNmae;
@property (nonatomic , copy) NSString *placeId;

@property (nonatomic , strong) NSMutableArray *placeNmaeArr;
@property (nonatomic , strong) NSMutableArray *placeIdArr;
@property (nonatomic , strong) NSMutableString *placeIDs;
@property (nonatomic , strong) NSMutableString *placeNames;
@property (nonatomic , strong) NSMutableDictionary *sendDicCheck;


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

@property (nonatomic , strong) NSMutableArray *selectCityArrMore;
@property (nonatomic , strong) NSMutableArray *selectCityCodeArrMore;

@property (nonatomic , strong) NSMutableString *Idtags;
@property (nonatomic , strong) NSMutableDictionary *sendDicId;


@property(nonatomic,strong)NSMutableArray *arrTransmit;
@property(nonatomic,strong)NSMutableDictionary *dicCheck;

@property(nonatomic,strong)NSMutableArray *arrTransmitMore;
@property(nonatomic,strong)NSMutableDictionary *dicCheckMore;

@property(nonatomic,strong)NSMutableArray *arrTransmitId;
@property(nonatomic,strong)NSMutableDictionary *dicCheckId;

@property(nonatomic,strong)NSMutableArray *arrTransmitPl;
@property(nonatomic,strong)NSMutableDictionary *dicCheckpl;

@property(nonatomic,strong)NSMutableArray *arrTransmitAg;
@property(nonatomic,strong)NSMutableDictionary *dicCheckAg;



@end
