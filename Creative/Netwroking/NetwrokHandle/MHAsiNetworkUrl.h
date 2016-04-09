//
//  MHAsiNetworkUrl.h
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#ifndef MHProject_MHAsiNetworkUrl_h
#define MHProject_MHAsiNetworkUrl_h
///**
// *  正式环境
// */
//#define API_HOST @"http://jiuchuangpt.chinacloudapp.cn:9080/jiuchuang_pingtai"

///**
// *   测试环境
// */
//#define API_HOST @"http://180.166.66.226:10081/jiuchuang_pingtai"
//#define API_HOST @"http://192.168.16.90:8080/jiuchuang_pingtai"

#define API_HOST @"http://192.168.16.7:8080/jiuchuang_pingtai"
//#define API_HOST @"http://192.168.16.166:8080/jiuchuang_pingtai"  //星哥
//#define API_HOST @"http://180.166.66.226:10080/jiuchuang_pingtai/api" //外网接口

//      接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:_path, API_HOST]
/**
 *   登陆的接口
 */
#define DEF_LOGIN  PATH(@"%@/phoneAppLogin")
/**
 *   验证码的接口
 */
#define DEF_VALIDATE  PATH(@"%@")

///////////////////////////// 路演  /////////////////////////////
///**
// *   路演关键字查找的接口
// */
#define DEF_LUYANGJZSEARCH  PATH(@"%@/queryRoadshow/queryRoadshow")
/**
 *   往期路演的接口
 */
#define DEF_LUYANSHOUYE  PATH(@"%@/queryRoadshow/getEndRoadshow")
/**
 *   路演成果列表的接口
 */
#define DEF_LYCHENGGUOLIEBIAO  PATH(@"%@/queryRoadshow/getResultPage")
/**
 *   路演评论列表的接口
 */
#define DEF_LYCOMMENTLIEBIAO  PATH(@"%@/querysCommentary/findPageOrAllList")
/**
 * 路演报名的接口
 */
#define DEF_LYSINGUP  PATH(@"%@/roadshow/addRoadshowApply")
/**
 *   路演详情列表的接口
 */
#define DEF_LYDETAIL  PATH(@"%@/queryRoadshow/getRoadshowDetail")
/**
 * 路演视频的接口
 */
#define DEF_LYSHIPIN  @"http://192.168.16.7/jiuchuang_admin/#/appointmentsApp/appointmentsApp/video"

/////////////////////////////  路演  /////////////////////////////


////////////////////////  活动  /////////////////////
/**
 * 活动接口
 */
#define DEF_ACTIVE  PATH(@"%@/querysActivity/queryActivity")
/**
 * 获取活动详情接口
 */
#define DEF_ACTIVEDETAIL  PATH(@"%@/activity/queryActivityDetail")

/**
 *   活动成果列表的接口
 */
#define DEF_HDCHENGGUOLIEBIAO  PATH(@"%@/activity/showActivityResult")

/**
 *   活动关键字查找的接口
 */
#define DEF_HDGJZSEARCH  PATH(@"%@/querysActivity/queryActivity")
/**
 * 活动报名的接口
 */
#define DEF_HDSINGUP  PATH(@"%@/activityApply/enrollActivity")

////////////////////////  活动  /////////////////////

/**
 *   找导师关键字查找的接口
 */
#define DEF_ZDSGJZSEARCH  PATH(@"%@/queryExpert/queryExpert")
/**
 *   找资金关键字查找的接口
 */
#define DEF_ZZJGJZSEARCH  PATH(@"%@/investment/queryInvestment")
/**
 *   找场地关键字查找的接口
 */
#define DEF_ZCDGJZSEARCH  PATH(@"%@/queryPlace/queryPlace")
/**
 *   轮播图的接口
 */
#define DEF_GJZSEARCH  PATH(@"%@/carouse/findAllPictureCarouse/10")

/**
 *   系统字典的接口
 */
#define DEF_XITONGZIDIAN  PATH(@"%@/console/sysDict/query")
/**
 *   地区的接口
 */
#define DEF_DIQU  PATH(@"%@/querysArea/findAreaList")
/**
 * 活动成果的接口
 */
#define DEF_HDCHENGGUO  @"http://192.168.16.7/jiuchuang_admin/#/appointmentsApp/appointmentsApp/active"
/**
 * 活动成果的接口
 */
#define DEF_HDBAOMING  PATH(@"%@/activityApply/enrollActivity")



/////////////////   项目  /////////////////////////////
/**
 * 获取项目列表接口(无登陆是项目列表查询接口)
 */
#define DEF_PROJECTLIST  PATH(@"%@/querysEngineer/queryEngineering")

/**
 * 获取项目详情接口
 */
#define DEF_PROJECTDETAIL  PATH(@"%@/queryEngineer/findDetail")

/**
 * 项目支持接口
 */
#define DEF_XIANGMUZHICHI  PATH(@"%@/rewardCrowd/addRewardCrowd")

/**
 * 项目查询投标接口
 */
#define DEF_XMCHAXUNTOUBIAO  PATH(@"%@/queryEngineer/findBid")
/**
 *   项目关键字查找的接口
 */
#define DEF_XMGJZSEARCH  PATH(@"%@/querysEngineer/queryEngineering")
#define DEF_XMGJZSEARCHYI  PATH(@"%@/querysEngineer/queryEngineering")

/**
 * 获取项目留言列表接口
 */
#define DEFPROJECTNOTE  PATH(@"%@/queryMessage/messageForBusiness")

/////////////////   项目  /////////////////////////////

/**
 * 增加私信接口
 */
#define DEF_FASIXIN  PATH(@"%@/privatechat/addPrivateChat")
/**
 * 投标提交接口
 */
#define DEF_XIANGMUTOUBIAO  PATH(@"%@/engineeringBid/addBid")

/**
 * 获取用户点赞接口
 */
#define DEF_HUOQUDIANZAN  PATH(@"%@/consoleService/getBusinessPraise")
/**
 * 点赞接口
 */
#define DEF_DIANZAN  PATH(@"%@/praise/addPraise")
/**
 * 取消点赞接口
 */
#define DEF_QUXIAODIANZAN  PATH(@"%@/praise/deletePraise")

/**
 *   获取验证码短信接口 (GET)
 */
#define DEF_VALIDATECODE  PATH(@"%@/register/validateCode")
/**
 *  检验验证码的接口
 */
#define DEF_CHECKVALIDATECODE  PATH(@"%@/register/checkValidateCode")

/**
 *   用户注册唯一性校验接口
 */
#define DEF_VALIDATION  PATH(@"%@/register/validation")
/**
 *   注册的接口
 */
#define DEF_REGISTER  PATH(@"%@/register/register")

/**
 *   发评论的接口 (POST)
 */
#define DEF_SENDCOMMENT  PATH(@"%@/commentary/addCommentary")
/**
 *   发留言的接口 (POST)
 */
#define DEF_ADDNOTES  PATH(@"%@/message/addMessage")
/**
 *   找导师列表的接口 (POST)
 */
#define DEF_ZHAODAOSHI  PATH(@"%@/queryExpert/queryExpert")
/**
 *   找资金列表的接口 (POST)
 */
#define DEF_ZHAOZIJIN  PATH(@"%@/investment/queryInvestment")
/**
 *   找资金详情的接口 (POST)
 */
#define DEF_ZHAOZIJINXIANGQING  PATH(@"%@/investment/showInvestment")

/**
 *   查看明信片的接口 (POST)
 */
#define DEF_GERENMINGXINPIAN  PATH(@"%@/postcard/findList")



/**
 *   查看个人信息的接口 (POST)
 */
#define DEF_GERENXINXI  PATH(@"%@/userInfoRest/webUser/findUserForInfo")
/**
 *   修改个人信息的接口 (POST)
 */
#define DEF_UPDATEGERENXINXI  PATH(@"%@/userInfoRest/webUser/updateUserForInfo")

/**
 *   找场地列表的接口 (POST)
 */
#define DEF_ZHAOPLACE  PATH(@"%@/queryPlace/queryPlace")
/**
 *   获取场地详情的接口 (POST)
 */
#define DEF_ZHAOPLACEDETAIL  PATH(@"%@/queryPlace/findDetail")

/**
 *   获取场地询价的接口 (POST)
 */
#define DEF_ZHAOPLACEENQUIRY  PATH(@"%@/place/addPlaceEnquiry")
/**
 *   投递项目的接口 (POST)
 */
#define DEF_TOUDIXIANGMU  PATH(@"%@/investmentEngineering/addInvestmentEngineering")

/**
 *   获取场地询价的接口 (POST)
 */
#define DEF_ZHAOPLACEENQUIRY  PATH(@"%@/place/addPlaceEnquiry")

/**
 *   发布场地需求的接口 (POST)
 */
#define DEF_PLACEREQUIRE  PATH(@"%@/placeDemand/addPlaceDemand")
/**
 *   获取关注状态的接口 (POST)
 */
#define DEF_HUOQUGUANZHU  PATH(@"%@/consoleService/getRelationship")

/**
 *   添加关注的接口 (POST)
 */
#define DEF_TIANJIAGZ  PATH(@"%@/relation/addRelation")
/**
 *   取消关注的接口 (POST)
 */
#define DEF_QUXIAOGZ  PATH(@"%@/relation/cancelRelation")

/**
 *   教育经历的接口 (POST)
 */
#define DEF_ZYJIAOYUJL  PATH(@"%@/education/findEducation")
/**
 *   添加教育经历的接口 (POST)
 */
#define DEF_ADDZYJIAOYUJL  PATH(@"%@/education/addEducationForApp")
/**
 *   更新教育经历的接口 (POST)
 */
#define DEF_UPDATEZYJIAOYUJL  PATH(@"%@/education/updateEducation")
/**
 *   删除教育经历的接口 (POST)
 */
#define DEF_DELZYJIAOYUJL  PATH(@"%@/education/delateEducation")

/**
 *   职业信息的接口 (POST)
 */
#define DEF_ZYZHIYEXX  PATH(@"%@/profession/findProfession")
/**
 *   添加职业信息的接口 (POST)
 */
#define DEF_ADDZYZHIYEXX  PATH(@"%@/profession/addProfessionForApp")

/**
 *   修改职业信息的接口 (POST)
 */
#define DEF_UPDATEZYZHIYEXX  PATH(@"%@/profession/updateProfession")
/**
 *   删除职业信息的接口 (POST)
 */
#define DEF_DELZYZHIYEXX  PATH(@"%@/profession/delateProfession")

/**
 *   成长足迹的接口 (POST)
 */
#define DEF_ZYCHENGZHANGZJ  PATH(@"%@/footprint/findFootPrint")
/**
 *   添加足迹的接口 (POST)
 */
#define DEF_ADDZYCHENGZHANGZJ  PATH(@"%@/footprint/addFootPrintForApp")
/**
 *   修改足迹的接口 (POST)
 */
#define DEF_UPDATEZYCHENGZHANGZJ  PATH(@"%@/footprint/updateFootPrint")
/**
 *   删除足迹的接口 (POST)
 */
#define DEF_DELZYCHENGZHANGZJ  PATH(@"%@/footprint/delateFootPrint")

/**
 *   申请成为专家的接口 (POST)
 */
#define DEF_APPLYFOREXPERT  PATH(@"%@/expert/addExpert")
/**
 *   我的发布和参加路演的接口 (POST)
 */
#define DEF_WDFBCJLUYAN  PATH(@"%@/roadshow/findMyRoadshow")
/**
 *   我的发布和参加项目的接口 (POST)
 */
#define DEF_WDFBCJXIANGMU  PATH(@"%@/engineer/queryInfo")
/**
 *   我的发布和参加活动的接口 (POST)
 */
#define DEF_WDFBCJHUODONG  PATH(@"%@/activity/queryActivitys")

/**
 *   我关注所有人的接口 (POST)
 */
#define DEF_WGZSYR  PATH(@"%@/consoleService/getMyRelation")
/**
 *   关注我的所有人的接口 (POST)
 */
#define DEF_GZWSYR  PATH(@"%@/consoleService/getMineRelationship")
/**
 *   相互关注的接口 (POST)
 */
#define DEF_XHGZ  PATH(@"%@/consoleService/getBothRelationship")

/**
 *   我的资金列表的接口 (POST)
 */
#define DEF_WDZJLB  PATH(@"%@/investment/queryMyInvestment")
/**
 *   我询价的场地的接口 (POST)
 */
#define DEF_WXJDCD  PATH(@"%@/place/findPlaceEnquiry")

/////////////////   孵化器  /////////////////////////////

/**
 *   孵化器的接口 (POST)
 */
#define DEF_FUHUAQISY  PATH(@"%@/userCompany/findListUserInfo")
/**
 *   孵化器标签的接口 (POST)
 */
#define DEF_FUHUAQIBQ  PATH(@"%@/queryIncubator/findPublicList")
/**
 *   孵化器基础信息的接口 (POST)
 */
#define DEF_FUHUAQIJICHUXX  PATH(@"%@/userInfoRest/webUser/showUserInfo")
/**
 *   孵化器服务列表的接口 (POST)
 */
#define DEF_FUHUAQIFUWULIEBIAO  PATH(@"%@/queryCompanyService/findServiceList")
/**
 *   孵化器联系方式列表的接口 (POST)
 */
#define DEF_FUHUAQILIANXIFS  PATH(@"%@/incubatorBusiness/queryIncubatorBusiness")
/**
 *   孵化器导师信息列表的接口 (POST)
 */
#define DEF_FUHUAQIDAOSHIXX  PATH(@"%@/incubatorTutor/queryIncubatorTutor")


/**
 *   孵化器校企合作的接口 (POST)
 */
#define DEF_FUHUAQIXIAOQIHEZUO  PATH(@"%@/companyAcademy/queryCompanyAcademy")



/**
 *   孵化器-校企合作详情h5的接口 (POST)
 */
#define DEF_XIAOQIHEZUO  @"http://192.168.16.7/jiuchuang_pingtai/#/incubatorApp/school"
/********************小秘书*********************/
/**
 *   小秘书的接口 (POST)
 */
#define DEF_XIAOMISHU  @"http://192.168.16.7/jiuchuang_pingtai/#/appointmentsApp/appointmentsApp/index"
/**
 *   找政务的接口 (POST)
 */
#define DEF_ZHAOZHENGWU  @"http://192.168.16.7/jiuchuang_pingtai/#/resourceApp/resourceApp/affair"
/**
 *   找营销的接口 (POST)
 */
#define DEF_ZHAOYINGXIAO  @"http://192.168.16.7/jiuchuang_pingtai/#/resourceApp/resourceApp/marketing"
/**
 *   找法务的接口 (POST)
 */
#define DEF_ZHAOFAWU  @"http://192.168.16.7/jiuchuang_pingtai/#/resourceApp/resourceApp/forensic"


/****************************创新创业体验*************/

/**
 *   检索约会接口 post
 */

#define DER_JIANSUOYUEHUI PATH(@"%@/appointment/querysAppointment")





 #endif
