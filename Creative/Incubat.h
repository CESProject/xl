//
//  Incubat.h
//  Creative
//
//  Created by huahongbo on 16/3/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IncubImage.h"
#import "Mentor.h"
@interface Incubat : NSObject
@property (nonatomic , copy) NSString *incubId;
@property (nonatomic , copy) NSString *companyName;
@property (nonatomic , copy) NSString *imageUrl;
@property(nonatomic, strong) IncubImage *image;


//服务能力
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *typeName;
@property (nonatomic , copy) NSString *customFeaturedService;
//联系方式
@property (nonatomic , copy) NSString *businessName;
@property (nonatomic , copy) NSString *contacts;//姓名
@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *qq;

//导师信息
@property(nonatomic, strong) Mentor *headImage;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *serviceArea;
@property (nonatomic , copy) NSString *incubatorId;
@end
