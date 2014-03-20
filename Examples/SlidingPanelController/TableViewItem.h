//  TableViewItem.h
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

#pragma mark - Interface

/**
 *  The `TableViewItem` class corresponds to an item of a table view. It indicates the name of the item and if this one is checked.
 */
@interface TableViewItem : NSObject <NSCopying>

#pragma mark Initialization
/** @name Initialization */

/**
 *  Create and return a checkable `TableViewItem` object.
 *
 *  @param name       The item's name. It must not be `nil`.
 *
 *  @return The `TableViewItem` object.
 */
+ (TableViewItem *)tableViewItemCheckableWithName:(NSString *)name;

/**
 *  Create and return a uncheckable `TableViewItem` object.
 *
 *  @param name The item's name. It must not be `nil`.
 *
 *  @return The `TableViewItem` object.
 */
+ (TableViewItem *)tableViewItemUncheckableWithName:(NSString *)name;

#pragma mark Item properties
/** @name Item properties */

/**
 *  Action to execute when the item is deselected.
 */
@property (nonatomic, copy)             void        (^actionWhenDeselected)(void);

/**
 *  Action to execute when the item is selected.
 */
@property (nonatomic, copy)             void        (^actionWhenSelected)(void);

/**
 *  Indicate if the item is checked.
 *  The default value is "NO".
 *  The value cannot be change if the item is uncheckable.
 */
@property (nonatomic, assign)           BOOL        checked;

/**
 *  Indicate if the item is checkable.
 */
@property (nonatomic, assign, readonly) BOOL        isCheckable;

/**
 *  The item's name.
 */
@property (nonatomic, strong)           NSString    *name;

@end
