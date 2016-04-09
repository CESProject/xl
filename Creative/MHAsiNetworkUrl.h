//
//  MHAsiNetworkUrl.h
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#ifndef MHProject_MHAsiNetworkUrl_h
#define MHProject_MHAsiNetworkUrl_h

/***********************************************/
//#define API_HOST @"http://192.168.16.7:8080/jiuchuang_pingtai/"


//生成环境下的服务器地址
//#define API_HOST @"http://42.159.225.200:8080"

#define PATH(_path) [NSString stringWithFormat:_path, API_HOST]
/**
 *   登陆的接口
 */
#define DEF_LOGIN  PATH(@"%@/mobilelogin")
/**
 *   验证码的接口
 */
#define DEF_VALIDATE  PATH(@"%@")

/**
 *   忘记密码的接口
 */
#define DEF_WANGJIMIMA  PATH(@"%@")

/**
 *   修改密码的接口
 */
#define DEF_XIUGAIMIMA  PATH(@"%@")

/**
 *   注册的接口
 */
#define DEF_REGISTER  PATH(@"%@")








#endif
