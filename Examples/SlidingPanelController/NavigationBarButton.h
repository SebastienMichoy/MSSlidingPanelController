//  NavigationBarButton.h
//
// Copyright © 2014-2015 Sebastien MICHOY and contributors.
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
