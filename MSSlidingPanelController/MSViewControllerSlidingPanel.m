//
//  MSViewControllerSlidingPanel.m
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 12/10/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "MSViewControllerSlidingPanel.h"

#pragma mark - Implementation

@implementation UIViewController (MSSlidingPanel)

#pragma mark Getting other related view controllers
/** @name Getting other related view controllers */

/**
 *  The nearest ancestor in the view controller hierarchy that is a sliding controller.
 *
 *  If the receiver or one of its ancestors is a child of a sliding controller, this property contains the owning sliding controller. This property is nil if the view controller is not embedded inside a navigation controller.
 */
- (MSSlidingPanelController *)slidingPanelController
{
    UIViewController    *parentViewController;
    
    parentViewController = [self parentViewController];
    while (parentViewController)
    {
        if ([parentViewController isKindOfClass:[MSSlidingPanelController class]])
            return ((MSSlidingPanelController *) parentViewController);
        
        parentViewController = [parentViewController parentViewController];
    }
    
    return (nil);
}

@end
