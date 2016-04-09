//
//  ModelImage.h
//  CoreDataSample
//
//  Created by zgy on 16/1/8.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelImage : NSObject

@property(nonatomic,   copy) NSString *absoluteImagePath;
@property(nonatomic, assign) int  commentCount;
@property(nonatomic,   copy) NSString *createDate;
@property(nonatomic,   copy) NSString *createId;
@property(nonatomic, strong) NSArray *imageList;
@property(nonatomic,   copy) NSString *maxUri;
@property(nonatomic,   copy) NSString *maxUrl;
@property(nonatomic,   copy) NSString *midUri;
@property(nonatomic,   copy) NSString *midUrl;
@property(nonatomic,   copy) NSString *minUri;
@property(nonatomic,   copy) NSString *minUrl;
@property(nonatomic,   copy) NSString *name;
@property(nonatomic,   copy) NSString *imageID;

/*写你需要的属性
 
 ...
 */





@end
