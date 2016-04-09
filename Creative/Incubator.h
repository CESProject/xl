//
//  Incubator.h
//  Creative
//
//  Created by huahongbo on 16/3/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incubator : NSObject
@property(nonatomic, strong) NSArray *content; ///< 这个数组里是ListFriend对象， .m告诉这个库
@property(nonatomic , copy) NSString *totalElements;
@property(nonatomic, assign) int  totalPages;

@end
