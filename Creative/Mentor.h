//
//  Mentor.h
//  Creative
//
//  Created by huahongbo on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mentor : NSObject
@property(nonatomic,   copy) NSString *absoluteImagePath;
@property(nonatomic, assign) int  commentCount;
@property(nonatomic,   copy) NSString *createDate;
@property(nonatomic,   copy) NSString *createId;
@end
