//
//  JXAppDelegate.m
//  JXKit
//
//  Created by 452720799@qq.com on 06/01/2018.
//  Copyright (c) 2018 452720799@qq.com. All rights reserved.
//

#import "JXAppDelegate.h"
#import "JXKit.h"

@implementation JXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    // https%3A%2F%2Fwww.baidu.com%3Fname%3D%E4%BD%A0%26age%3D7834%26%2A%2F%5D%2Arrrr
    // https%3A%2F%2Fwww.baidu.com%3Fname%3D%E4%BD%A0%26age%3D7834%26%2A%2F%5D%2Arrrr

//    NSString *tempString = @"https://www.baidu.com?name=你&age=7834&*/]*rrrr";
//
//    // https://www.baidu.com?name=%E4%BD%A0&age=7834&*/%5D*rrrr
//    // https://www.baidu.com?name=%E4%BD%A0&age=7834&*/%5D*rrrr
//
//    NSString *en = urlValue(tempString).absoluteString;
//
//    NSString *de = [en jx_URLDecoded];
//
//    NSLog(@"");

//
//    NSString *didString = URLStringValue(tempString);
//    didString = URLStringValue(didString);
//    didString = URLStringValue(didString);
//    didString = URLStringValue(didString);
//    NSURL *didURL = URLValue(tempString);
    
//    NSString *num = [NSString jx_decimalStyle:3.001f];
//    NSString *num = [NSString jx_priceDecimalString:123456.789];
    NSString *num = [NSString jx_priceDecimalStyleString:123456.789];
    NSLog(@"%@", num);
    
    
    
    

    
//    temp = @"https://app.mixcapp.com/h5/invitation/templets/invitation.html?inviteCode=WXycOpbl&userName=%E4%BA%8C%E7%BB%B4%E7%A0%81&appVersion=2.7.1&mallNo=0202A003&timestamp=1527912762798";
    
//    NSURLComponents *com = [[NSURLComponents alloc] initWithString:@"https://www.baidu.com?name=你&age=%"];
////
//    NSURL *url = com.URL;
    
//    NSURL *url = urlValue(temp.absoluteString);
//    url = urlValue(url.absoluteString);
//    url = urlValue(url.absoluteString);
//    url = urlValue(url.absoluteString);
//
//    NSString *s = urlEncode(@"mixc/wwcom?name=你&age=%");

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
