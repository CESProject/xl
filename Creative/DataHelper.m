//
//  DataHelper.m
//  Creative
//
//  Created by 微启 on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper
-(void) GETRequest:(NSString *)urlstring{
    
    NSURL *url=[NSURL  URLWithString:urlstring];
    
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] initWithURL:url];
    //得到session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建一个task任务
    
    NSURLSessionTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            
            id obj=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            [self.delegate backValue:obj];
        }else{
            NSLog(@"%@",error);
        }
    }];
    
    [task resume];//开始任务
}
-(void)POSTRequest:(NSString *)urlStr andParameter:(NSString *)parameterStr{
    //创建请求路径
    NSURL *url=[NSURL  URLWithString:urlStr];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    //得到session对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSData *parmdata=[parameterStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:parmdata];
    [request setHTTPMethod:@"POST"];
    
    //创建一个task任务
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            
            id obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            [self.delegate backValue:obj];
        }
        else {
            NSLog(@"%@",error);
        }
    }];
    [task resume];//开始任务
}@end
