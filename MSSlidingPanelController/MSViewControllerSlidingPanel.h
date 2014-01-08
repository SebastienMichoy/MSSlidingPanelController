//
//  MSViewControllerSlidingPanel.h
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 12/10/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSSlidingPanelController.h"

#pragma mark - Interface

/**
 *  The UIViewController extension allows to get an sliding controller object if it is a parent.
 */
@interface UIViewController (MSSligingPanel)

#pragma mark Getting other related view controllers
/** @name Getting other related view controllers */

/**
 *  The nearest ancestor in the view controller hierarchy that is a sliding controller.
 *
 *  If the receiver or one of its ancestors is a child of a sliding controller, this property contains the owning sliding controller. This property is nil if the view controller is not embedded inside a navigation controller.
 */
@property (nonatomic, strong, readonly) MSSlidingPanelController    *slidingPanelController;

@end
