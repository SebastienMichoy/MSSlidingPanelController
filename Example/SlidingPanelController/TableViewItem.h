//
//  TableViewItem.h
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 28/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

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
