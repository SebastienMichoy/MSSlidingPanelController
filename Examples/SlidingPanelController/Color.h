//  Color.h
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
