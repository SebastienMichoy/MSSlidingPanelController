//
//  Color.h
//  Music
//
//  Created by Sébastien MICHOY on 14/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  UIColor (Color) adds new colors to the basic UIColor class.
 */
@interface UIColor (Color)

#pragma mark - Create colors
/** @name Create colors */

/**
 *  Creates and returns a color object using the specified opacity and RGB component values.
 *
 *  @param red   The red component of the color object, specified as a value from 0 to 255.
 *  @param green The green component of the color object, specified as a value from 0 to 255.
 *  @param blue  The blue component of the color object, specified as a value from 0 to 255.
 *  @param alpha The opacity value of the color object, specified as a value from 0 to 255.
 *
 *  @return The color object. The color information represented by this object is in the device RGB colorspace.
 */
+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha;

#pragma mark - Center view colors
/** @name Center view colors */

/**
 *  Return the background color of the center view.
 *
 *  @return The color object.
 */
+ (UIColor *)centerBackgroundColor;

/**
 *  Return the navigation bar background color.
 *
 *  @return The color object.
 */
+ (UIColor *)centerNavBarBackgroundColor;

/**
 *  Return the text background color of the table view footer.
 *
 *  @return The color object.
 */
+ (UIColor *)centerTableViewFooterTextColor;

/**
 *  Return the table view section background color.
 *
 *  @return The color object.
 */
+ (UIColor *)centerTableViewSectionBackgroundColor;

#pragma mark - Menu colors
/** @name Menu colors */

/**
 *  Return the background color of the menu.
 *
 *  @return The color object.
 */
+ (UIColor *)menuBackgroundColor;

/**
 *  Return the color of the status bar when the menu view is displayed.
 *
 *  @return The color object.
 */
+ (UIColor *)menuStatusBarColor;

/**
 *  Return the background color of the menu's table view cells.
 *
 *  @return The color object.
 */
+ (UIColor *)menuTableViewCellBackgroundColor;

/**
 *  Return the background color of the menu's table view selected cells.
 *
 *  @return The color object.
 */
+ (UIColor *)menuTableViewCellBackgroundSelectedColor;

/**
 *  Return the text color of the menu's table view cells.
 *
 *  @return The color object.
 */
+ (UIColor *)menuTableViewCellTextColor;

/**
 *  Return the text color of the menu's table view selected cells.
 *
 *  @return The color object.
 */
+ (UIColor *)menuTableViewCellTextSelectedColor;

/**
 *  Return the color of the menu's table view separators.
 *
 *  @return The color object.
 */
+ (UIColor *)menuTableViewSeparatorsColor;

#pragma mark - Navigation bar buttons
/** @name Navigation bar buttons */

/**
 *  Return the color of the navigation bar of type "Menu".
 *
 *  @return The color object.
 */
+ (UIColor *)navigationBarMenuColor;

@end
