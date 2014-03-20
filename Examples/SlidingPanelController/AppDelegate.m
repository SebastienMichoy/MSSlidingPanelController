//  AppDelegate.m
//
// Copyright (c) 2014 Sébastien MICHOY
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer. Redistributions in binary
// form must reproduce the above copyright notice, this list of conditions and
// the following disclaimer in the documentation and/or other materials
// provided with the distribution. Neither the name of the nor the names of
// its contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
