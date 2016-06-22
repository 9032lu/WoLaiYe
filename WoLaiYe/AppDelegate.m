//
//  AppDelegate.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UnitViewController.h"
#import "RoundsViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"


@interface AppDelegate ()

{
    UITabBarController *tabBarController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    self.window.backgroundColor =[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    //初始化控制器
    [self loadTabBarVC];
    return YES;
}

-(void)loadTabBarVC{
    {
         HomeViewController*vc1=[[HomeViewController alloc]init];
        UINavigationController*nav1=[[UINavigationController alloc]initWithRootViewController:vc1];
        
        UnitViewController *vc2=[[UnitViewController alloc]init];
        UINavigationController*nav2=[[UINavigationController alloc]initWithRootViewController:vc2];
        
        RoundsViewController *vc3=[[RoundsViewController alloc]init];
        UINavigationController*nav3=[[UINavigationController alloc]initWithRootViewController:vc3];
        
        MessageViewController  *vc4=[[MessageViewController alloc]init];
        UINavigationController*nav4=[[UINavigationController alloc]initWithRootViewController:vc4];
        
        MineViewController *vc5 = [[MineViewController alloc]init];
        UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:vc5];
        
        
        
        tabBarController = [[UITabBarController alloc]init];
        NSArray *array = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4,nav5, nil];
        tabBarController.viewControllers = array;
        
        UITabBar *tb=tabBarController.tabBar;
        [tb setTintColor:APP_ClOUR];
        [tb setBackgroundColor:RGB(234, 234, 234)];
        
        UITabBarItem    *tbm1=[tb.items objectAtIndex:0];
        UITabBarItem    *tbm2=[tb.items objectAtIndex:1];
        UITabBarItem    *tbm3=[tb.items objectAtIndex:2];
        UITabBarItem    *tbm4=[tb.items objectAtIndex:3];
        UITabBarItem    *tbm5=[tb.items objectAtIndex:4];

        
        tbm1.title=@"首页";
        tbm2.title=@"格子";
        tbm3.title=@"牛人圈";
        tbm4.title=@"消息";
        tbm5.title=@"我的";

        
        tbm1.image=[[UIImage imageNamed:@"tab_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tbm1.selectedImage=[[UIImage imageNamed:@"tab_home_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tbm2.image=[[UIImage imageNamed:@"tab_discover"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tbm2.selectedImage=[[UIImage imageNamed:@"tab_discover_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tbm3.image=[[UIImage imageNamed:@"tab_timeline"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tbm3.selectedImage=[[UIImage imageNamed:@"tab_timeline_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tbm4.image=[[UIImage imageNamed:@"tab_message"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tbm4.selectedImage=[[UIImage imageNamed:@"tab_message_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tbm5.image=[[UIImage imageNamed:@"tab_profile"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tbm5.selectedImage=[[UIImage imageNamed:@"tab_profile_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        self.window.rootViewController = tabBarController;
        
        
    }
}
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
