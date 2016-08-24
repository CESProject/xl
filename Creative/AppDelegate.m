//
//  AppDelegate.m
//  Creative
//
//  Created by huahongbo on 15/12/28.
//  Copyright © 2015年 王文静. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftSortsViewController.h"
#import "LoginViewController.h"
#import "WelcomePageVC.h"
#import "placeModel.h"
#import "common.h"
#import "SQLiteBase.h"
#import "KnowledgeViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate
/**
    哦多克 思密达  测试数据  厦航写的
 
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   NetworkStatus st = [[HttpManager defaultManager] networkStatus];
    if (st==0)
    {
        showAlertView(@"请连接网络")
    }
//    [self prepareForAppInitialization];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        MainViewController *mainVC = [[MainViewController alloc] init];

        [self openLeftVC:mainVC];
    }else
    {
        [self loginView];
    }

    
    [self loadPlaceList];
    
    [[UINavigationBar appearance] setBarTintColor:GREENCOLOR];
    
    return YES;
}
- (void)loginView
{
//    KnowledgeViewController *loginVC = [[KnowledgeViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    self.window.rootViewController = nav;
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}
- (void)loadPlaceList
{// 省
    
    SQLiteBase *sqlitePlaceTable = [SQLiteBase ShareSQLiteBaseSave];
    [sqlitePlaceTable createWithTableName:@"provinceList"];
    [sqlitePlaceTable createWithTableName:@"cityList"];
//    [sqlitePlaceTable createWithTableName:@"countryList"];
    
    dispatch_queue_t queue = dispatch_queue_create("searchSqlite", DISPATCH_QUEUE_SERIAL);
    //开始给创建的队列里面添加任务
    dispatch_async(queue, ^{
        NSLog(@" 任务1执行---%@", [NSThread currentThread]);
        NSMutableArray *provinceList = [sqlitePlaceTable searchAllDataFromTableName:@"provinceList"] ;
        if (provinceList.count == 0)
        {
            [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(1)} complete:^(BOOL successed, NSDictionary *result) {
                
                NSMutableArray *proArr = [NSMutableArray array];
                for ( NSDictionary *dic  in result[@"objList"]) {
                    placeModel *plcae = [placeModel objectWithKeyValues:dic];
                    [proArr addObject:plcae];
                    [sqlitePlaceTable createWithTableName:@"provinceList" withModel:plcae];
                    
                }
                
            }];
        }

    });
    dispatch_async(queue, ^{
        NSLog(@" 任务2执行----%@", [NSThread currentThread]);
        NSMutableArray *cityList = [sqlitePlaceTable searchAllDataFromTableName:@"cityList"] ;
        if (cityList.count == 0)
        {
            // 市
            [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(2)} complete:^(BOOL successed, NSDictionary *result) {
                
                NSMutableArray *proArr = [NSMutableArray array];
                for ( NSDictionary *dic  in result[@"objList"]) {
                    placeModel *plcae = [placeModel objectWithKeyValues:dic];
                    
                    [proArr addObject:plcae];
                    [sqlitePlaceTable createWithTableName:@"cityList" withModel:plcae];
                }
                
                
            }];
        }
        

    });
    /*
    dispatch_async(queue, ^{
        NSLog(@" 任务3执行---%@", [NSThread currentThread]);
        
        NSMutableArray *countryList = [sqlitePlaceTable searchAllDataFromTableName:@"countryList"] ;
        if (countryList.count == 0)
        {
            // 县
            [[HttpManager defaultManager]postRequestToUrl:DEF_DIQU params:@{@"areaLevel":@(3)} complete:^(BOOL successed, NSDictionary *result) {
                
                NSMutableArray *proArr = [NSMutableArray array];
                for ( NSDictionary *dic  in result[@"objList"]) {
                    placeModel *plcae = [placeModel objectWithKeyValues:dic];
                    [sqlitePlaceTable createWithTableName:@"countryList" withModel:plcae];
                    [proArr addObject:plcae];
                }
                
            }];
        }

    });
    */
    
}
- (void)prepareForAppInitialization
{
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    BOOL needLoadWelcomePage = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"NeedLoadWelcomePage"] boolValue];//模仿微信（并不是每次更新都显示欢迎页），默认YES
    
    NSString *lastVersion = [UD stringForKey:@"lastVersion"];
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if(!lastVersion)
    {
        //没有这个key
        [self loadWelcomePage];
        
    }else if (needLoadWelcomePage && ![localVersion isEqualToString:lastVersion]){
        //本地的 和 之前存的  不一样
        [self loadWelcomePage];
    }else
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
            MainViewController *mainVC = [[MainViewController alloc] init];

            [self openLeftVC:mainVC];
        }else
        {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            self.window.rootViewController = nav;
        }
    }
}
- (void)loadWelcomePage
{
    __weak typeof(self) weakSelf = self;
    WelcomePageVC *vc = [[WelcomePageVC alloc]init];
    [vc setEndTapThePage:^{
        
        //欢迎页最后把 本地的版本号存起来
        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:localVersion forKey:@"lastVersion"];
//        weakSelf.window.rootViewController = [[BaseTabbarViewController alloc] init];//进入主页面
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
                MainViewController *mainVC = [[MainViewController alloc] init];

            [weakSelf openLeftVC:mainVC];
        }else
        {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            weakSelf.window.rootViewController = nav;
        }
    }];
    
    self.window.rootViewController = vc;
}
- (void)openLeftVC:(id)mainVC
{
//    MainViewController *mainVC = [[MainViewController alloc] init];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
    
}

//- (void)openLeftVC
//{
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
//    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
//    self.window.rootViewController = self.LeftSlideVC;
//
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
