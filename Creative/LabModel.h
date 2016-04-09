//
//  LabModel.h
//  Creative
//
//  Created by huahongbo on 16/3/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabModel : NSObject
@property (nonatomic , copy) NSString *tagName;
@property (nonatomic , copy) NSString *tagDesc;
@property (nonatomic , assign) int labId;

@property(nonatomic, copy)NSString *iconName;
@end
