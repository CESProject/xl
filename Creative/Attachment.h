//
//  Attachment.h
//  Creative
//
//  Created by huahongbo on 16/1/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attachment : NSObject
@property(nonatomic,   copy) NSString *createDate;
@property(nonatomic,   copy) NSString *fileType;
@property(nonatomic,   copy) NSString *htmlPath;
@property(nonatomic,   copy) NSString *fujianId; //附件Id
@property(nonatomic,   copy) NSString *orgId;
@property(nonatomic,   copy) NSString *resourceName;
@property(nonatomic,   copy) NSString *resourceUri;
@property(nonatomic,   copy) NSString *resourceUrl;
@property(nonatomic,   copy) NSString *shortName;
@property(nonatomic,   copy) NSString *urlType;
@property(nonatomic,   copy) NSString *userId;

@property(nonatomic, assign) int  size;
@end
