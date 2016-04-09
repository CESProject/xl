//
//  DataHelper.h
//  Creative
//
//  Created by 微启 on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DateHelperDelegate<NSObject>
-(void) backValue:(id) obj;
@end
@interface DataHelper : NSObject

-(void) GETRequest:(NSString *) urlstring;

-(void) POSTRequest:(NSString *) urlStr  andParameter:(NSString *) parameterStr;

@property (assign,nonatomic) id<DateHelperDelegate> delegate;
@end
