//
//  NavigationBarButton.h
//  Music
//
//  Created by Sébastien MICHOY on 27/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    NavigationBarButtonTypeCustom,
    NavigationBarButtonTypeMenu,
}   NavigationBarButtonType;

@interface NavigationBarButton : UIButton

#pragma mark - Initializing the button
/** @name Initializing the button */

/**
*  Creates and returns a new button of the specified type.
*
*  @param navigationBarButtonType The button type.
*
*  @return The button type.
*/
+ (NavigationBarButton *)buttonWithType:(NavigationBarButtonType)navigationBarButtonType;

#pragma mark - Getting and setting properties
/** @name Getting and setting properties */

/**
 *  The selector defining the action message to send to the target object when the user taps this button.
 */
@property (nonatomic)                   SEL                     action;

/**
 *  The button type.
 */
@property (nonatomic, assign, readonly) NavigationBarButtonType navigationBarButtonType;

/**
 *  The object that receives an action when the item is selected.
 */
@property (nonatomic, weak)             id                      target;

@end
