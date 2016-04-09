//
//  moveModel.h
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moveModel : NSObject

@property (nonatomic , copy) NSString *strCode;
@property (nonatomic , copy) NSString *lists;
@property (nonatomic , copy) NSString *msg;
@property (nonatomic , copy) NSString *obj;
@property (nonatomic , strong) NSMutableArray *objList;

//code = 10000;
//lists = "<null>";
//msg = success;
//obj = "<null>";
//objList

@end
