//
//  User.m
//  Creative
//
//  Created by huahongbo on 16/1/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "User.h"

@implementation User
// 解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.userId=[aDecoder decodeObjectForKey:@"userId"];
        self.loginName=[aDecoder decodeObjectForKey:@"loginName"];
        self.userName=[aDecoder decodeObjectForKey:@"userName"];
        self.password=[aDecoder decodeObjectForKey:@"password"];
    }
    return  self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
}
@end
