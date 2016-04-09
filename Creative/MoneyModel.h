//
//  MoneyModel.h
//  Creative
//
//  Created by huahongbo on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoneyContent.h"
@interface MoneyModel : NSObject
@property(nonatomic, strong) NSArray *content; ///< 这个数组里是ListFriend对象， .m告诉这个库
@property(nonatomic, assign) int  firstPage;
@property(nonatomic, assign) int  lastPage;
@property(nonatomic, assign) int  number;
@property(nonatomic, assign) int  numberOfElements;
@property(nonatomic, assign) int  size;
@property(nonatomic, assign) int  totalElements;
@property(nonatomic, assign) int  totalPages;
@end
