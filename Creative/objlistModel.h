//
//  objlistModel.h
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objlistModel : NSObject

@property (nonatomic , copy) NSString *strID;
@property (nonatomic , copy) NSString *businessId;
@property (nonatomic , copy) NSString *categoryId;
@property (nonatomic , copy) NSString *createBy;
@property (nonatomic , copy) NSString *createDate;
@property (nonatomic , copy) NSString *delDate;
@property (nonatomic , copy) NSString *delFlg;
@property (nonatomic , strong) NSMutableDictionary *imageDic;
@property (nonatomic , copy) NSString *imageId;
@property (nonatomic , copy) NSString *superCategoryId;
@property (nonatomic , copy) NSString *updateBy;
@property (nonatomic , copy) NSString *updateDate;
//businessId = 402881e550bcb9320150bcee617b0005;
//categoryId = 10;
//createBy = 1;
//createDate = 1446280416000;
//delDate = "<null>";
//delFlg = 0;
//id = 402881e550bcb9320150bd07cd770016;
//image =             {     };
//imageId = 326;
//superCategoryId = 10;
//updateBy = "<null>";
//updateDate = "<null>";

@end
