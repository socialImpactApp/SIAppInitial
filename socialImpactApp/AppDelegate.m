//
//  AppDelegate.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/6/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration * config =  [ParseClientConfiguration configurationWithBlock: ^ (id < ParseMutableClientConfiguration > _Nonnull configuration) {
        configuration.applicationId = @"siAppID";
        configuration.clientKey = @"siKey";
        configuration.server = @"https://siappfbu.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UITabBarItem *item = (UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:0];
    item.image = [UIImage imageNamed:@"imageedit__5380272865"];
    
    [self skipLoginScreenIfLoggedIn];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"hooray this works");
    [viewController viewWillAppear:YES];
}

-(void)skipLoginScreenIfLoggedIn {
    
    if ([PFUser currentUser]) {
        NSLog(@"skipLoginScreen");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
        
        
        
        //        [self setRootViewControllerHavingStoryBoardIdentifier:@"mainPics"];  // Overriding Storyboard settings.
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
