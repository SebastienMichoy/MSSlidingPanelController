//
//  NavigationBarButton.m
//  Music
//
//  Created by Sébastien MICHOY on 27/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "Color.h"
#import "NavigationBarButton.h"

@interface NavigationBarButton ()

/**
 *  The button type.
 */
@property (nonatomic, assign)   NavigationBarButtonType navigationBarButtonType;

@end

@implementation NavigationBarButton

#pragma mark - Initializing the button
/** @name Initializing the button */

/**
*  Creates and returns a new button of the specified type.
*
*  @param navigationBarButtonType The button type.
*
*  @return The button type.
*/
+ (NavigationBarButton *)buttonWithType:(NavigationBarButtonType)navigationBarButtonType
{
    CGRect              frame;
    NavigationBarButton *navigationBarButton;
    
    switch (navigationBarButtonType)
    {
        case NavigationBarButtonTypeMenu:
            frame = CGRectMake(0, 0, 18, 14);
            break;
            
        default:
            frame = CGRectMake(0, 0, 44, 44);
            break;
    }
    
    navigationBarButton = [[NavigationBarButton alloc] initWithFrame:frame];
    [navigationBarButton setNavigationBarButtonType:navigationBarButtonType];
    
    return (navigationBarButton);
}

/**
*  Initilizing the button.
*
*  @param frame The frame.
*
*  @return The button.
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setAction:NULL];
        [self setNavigationBarButtonType:NavigationBarButtonTypeCustom];
        [self setTarget:nil];
    }
    
    return (self);
}

#pragma mark - Draw the button
/** @name Draw the button */

/**
 *  Draws the receiver’s image within the passed-in rectangle.
 *
 *  @param rect The portion of the view’s bounds that needs to be updated. The first time your view is drawn, this rectangle is typically the entire visible bounds of your view. However, during subsequent drawing operations, the rectangle may specify only part of your view.
 */
- (void)drawRect:(CGRect)rect
{
    if ([self navigationBarButtonType] == NavigationBarButtonTypeMenu)
    {
        UIBezierPath* rectangleTopPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0.5, 18, 1) cornerRadius: 0.5];
        [[UIColor navigationBarMenuColor] setStroke];
        rectangleTopPath.lineWidth = 1;
        [rectangleTopPath stroke];
        
        UIBezierPath* rectangleMiddlePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 6.5, 18, 1) cornerRadius: 0.5];
        [[UIColor navigationBarMenuColor] setStroke];
        rectangleMiddlePath.lineWidth = 1;
        [rectangleMiddlePath stroke];
        
        UIBezierPath* rectangleBottomPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 12.5, 18, 1) cornerRadius: 0.5];
        [[UIColor navigationBarMenuColor] setStroke];
        rectangleBottomPath.lineWidth = 1;
        [rectangleBottomPath stroke];
    }
}

#pragma mark - Getting and setting properties
/** @name Getting and setting properties */

/**
 *  Set the selector defining the action message to send to the target object when the user taps this button.
 */
- (void)setAction:(SEL)action
{
    if ([self action] && [self target])
        [self removeTarget:[self target] action:[self action] forControlEvents:UIControlEventTouchDown];
    
    _action = action;
    
    if ([self action] && [self target])
        [self addTarget:[self target] action:[self action] forControlEvents:UIControlEventTouchDown];
}

/**
 *  Set the object that receives an action when the item is selected.
 */
- (void)setTarget:(id)target
{
    if ([self action] && [self target])
        [self removeTarget:[self target] action:[self action] forControlEvents:UIControlEventTouchDown];
    
    _target = target;
    
    if ([self action] && [self target])
        [self addTarget:[self target] action:[self action] forControlEvents:UIControlEventTouchDown];
}

@end
