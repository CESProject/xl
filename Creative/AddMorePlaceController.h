//
//  AddMorePlaceController.h
//  Creative
//
//  Created by Mr Wei on 16/2/3.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMorePlaceController : UIViewController

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *arrTransmit;
@property(nonatomic,strong)NSMutableDictionary *dicCheck;
@property(nonatomic,strong)NSMutableArray *reArrTransmit;
@property(nonatomic,strong)NSMutableDictionary *reDicCheck;

@property (nonatomic , assign) int passVc; //  3：表示从资源库导师 4：表示从资源库找资金

@end
