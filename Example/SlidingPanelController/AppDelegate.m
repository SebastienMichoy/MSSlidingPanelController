//
//  AppDelegate.m
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 28/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "AppDelegate.h"
#import "CenterViewController.h"
#import "Color.h"
#import "LeftPanelViewController.h"
#import "MSSlidingPanelController.h"
#import "RightPanelViewController.h"

#pragma mark - Implementation

@implementation AppDelegate

#pragma mark Application life cycle
/** @name Application life cycle */

/**
 *  Tells the delegate that the launch process is almost done and the app is almost ready to run.
 *
 *  @param application   The singleton app object.
 *  @param launchOptions The launch options.
 *
 *  @return NO if the app cannot handle the URL resource, otherwise return YES. The return value is ignored if the app is launched as a result of a remote notification.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CenterViewController        *centerViewController;
    LeftPanelViewController     *leftPanelViewController;
    MSSlidingPanelController    *slidingPanelController;
    RightPanelViewController    *rightPanelViewController;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    centerViewController = [[CenterViewController alloc] initWithNibName:nil bundle:nil];
    leftPanelViewController = [[LeftPanelViewController alloc] initWithNibName:nil bundle:nil];
    rightPanelViewController = [[RightPanelViewController alloc] initWithNibName:nil bundle:nil];

    slidingPanelController = [[MSSlidingPanelController alloc] initWithCenterViewController:centerViewController leftPanelController:leftPanelViewController andRightPanelController:rightPanelViewController];
    [slidingPanelController setLeftPanelStatusBarColor:[UIColor menuStatusBarColor]];
    [slidingPanelController setRightPanelStatusBarColor:[UIColor menuStatusBarColor]];
    [slidingPanelController setDelegate:centerViewController];
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [[self window] setRootViewController:slidingPanelController];
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    return (YES);
}

@end
