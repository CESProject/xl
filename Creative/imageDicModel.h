//
//  imageDicModel.h
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageDicModel : NSObject


@property (nonatomic , copy) NSString *strID;
@property (nonatomic , copy) NSString *strSize;
@property (nonatomic , copy) NSString *strType;
@property (nonatomic , copy) NSString *strWidth;
@property (nonatomic , copy) NSString *absoluteImagePath;
@property (nonatomic , copy) NSString *commentCount;
@property (nonatomic , copy) NSString *createDate;
@property (nonatomic , copy) NSString *createId;
@property (nonatomic , copy) NSString *flag;
@property (nonatomic , copy) NSString *height;
@property (nonatomic , strong) NSMutableArray *imageList;
@property (nonatomic , copy) NSString *maxUri;
@property (nonatomic , copy) NSString *maxUrl;
@property (nonatomic , copy) NSString *midUri;
@property (nonatomic , copy) NSString *midUrl;
@property (nonatomic , copy) NSString *minUri;
@property (nonatomic , copy) NSString *mobileUri;
@property (nonatomic , copy) NSString *mobileUrl;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *orgId;
@property (nonatomic , copy) NSString *praiseCount;
@property (nonatomic , copy) NSString *remark;

//absoluteImagePath = "http://192.168.16.7:8080/downloadFile/2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927.JPG";
//commentCount = 0;
//createDate = "2015-10-31 08:24:52";
//createId = 2;
//flag = "<null>";
//height = "<null>";
//id = 326;
//imageList =                 ( );
//maxUri = "/downloadFile/2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927.JPG";
//maxUrl = "2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927.JPG";
//midUri = "/downloadFile/2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927-mid.JPG";
//midUrl = "2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927-mid.JPG";
//minUri = "/downloadFile/2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927-min.JPG";
//minUrl = "2015-10-31/image/d6437e46-ba2e-49d0-afe2-879586c2c9af-9927-min.JPG";
//mobileUri = "/downloadFile/null";
//mobileUrl = "<null>";
//name = "\U9879\U76ee\U8def\U6f143.JPG";
//orgId = "<null>";
//praiseCount = 0;
//remark = "<null>";
//size = "<null>";
//type = JPG;
//width = "<null>";


@end
