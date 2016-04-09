//
//  ProjectSearchView.h
//  Creative
//
//  Created by Mr Wei on 16/2/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProjectSearchViewDelegate <NSObject>

- (void)passViewControl;

@end


@interface ProjectSearchView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,assign) id <ProjectSearchViewDelegate>delegate;

@property (nonatomic , strong) UIView *leftView;

@property (nonatomic , strong) UITableView *leftTableView;
@property (nonatomic , strong) UIView *areaView;

@property(nonatomic,strong)UITableView *mytableview;

@property(nonatomic,strong)UITableView *JiePaTableview;
@property(nonatomic,strong)UITableView *JieZoTableview;

@property(nonatomic,strong)UITableView *tenderTableview;
@property(nonatomic,strong)UITableView *personTableview;
@property(nonatomic,strong)UITableView *moneyTableview;
@property(nonatomic,strong)UITableView *personNumTableview;

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


@property(nonatomic,strong)NSMutableArray *arrTransmit;
@property(nonatomic,strong)NSMutableDictionary *dicCheck;

@property(nonatomic,strong)NSMutableArray *arrTransmitZJ;
@property(nonatomic,strong)NSMutableDictionary *dicCheckZJ;
@property (nonatomic , copy) NSString *zjStr;

@property(nonatomic,strong)NSMutableArray *arrTransmitPa;
@property(nonatomic,strong)NSMutableDictionary *dicCheckPa;
@property (nonatomic , copy) NSString *PaStr;

@property(nonatomic,strong)NSMutableArray *arrTransmitTen;
@property(nonatomic,strong)NSMutableDictionary *dicCheckTen;
@property (nonatomic , copy) NSString *TenStr;


@property(nonatomic,strong)NSMutableArray *arrTransmitType;
@property(nonatomic,strong)NSMutableDictionary *dicCheckType;
@property (nonatomic , copy) NSString *TypeStr;

@property(nonatomic,strong)NSMutableArray *arrTransmitMone;
@property(nonatomic,strong)NSMutableDictionary *dicCheckMone;
@property (nonatomic , copy) NSString *MoneStr;

@property(nonatomic,strong)NSMutableArray *arrTransmitNum;
@property(nonatomic,strong)NSMutableDictionary *dicCheckNum;
@property (nonatomic , copy) NSString *NumStr;


@property(nonatomic,strong)NSMutableArray *arrTransmitPl;
@property(nonatomic,strong)NSMutableDictionary *dicCheckpl;


@property (nonatomic , copy) NSString *shapeStr;

@end
