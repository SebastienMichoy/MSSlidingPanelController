//
//  TableViewSection.h
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 28/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableViewItem.h"

#pragma mark - Enumeration

/**
 *  An enumeration for the different rules of selection of a section.
 */
typedef NS_ENUM(NSInteger, SelectionRule)
{
    /**
     *  Nobody can be selected.
     */
    SelectionRuleNone,
    
    /**
     *  Only one row of the section can be selected.
     */
    SelectionRuleOnlyOne,
    
    /**
     *  Several rows of the section can be selected simultaneously.
     */
    SelectionRuleMultiple,
};

#pragma mark - Interface

/**
 *  The `TableViewSection` class corresponds to a section of a table view. It indicates the name of the section and the list of the its items.
 */
@interface TableViewSection : NSObject

#pragma mark Initialization
/** @name Initialization */

/**
 *  Create and return a `TableViewSection` object.
 *
 *  @param name          The section's name. It must not be `nil`.
 *  @param selectionRule The section's selection rule.
 *  @param items         The items, ended by nil. The incompatible items will dropped.
 *
 *  @return The `UITableViewSection` object.
 */
+ (TableViewSection *)tableViewSectionWitName:(NSString *)name selectionRule:(SelectionRule)selectionRule andItems:(TableViewItem *)items, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark Section information
/** @name Section information */

/**
 *  The section's name.
 */
@property (nonatomic, strong)           NSString        *name;

/**
 *  The section's selection rule.
 */
@property (nonatomic, assign, readonly) SelectionRule   selectionRule;

#pragma mark Manage items
/** @name Manage items */

/**
 *  Return a copy of the item at the index.
 *
 *  @param index The index.
 *
 *  @return A copy of the item. Is nil if the index is out of bounds.
 */
- (TableViewItem *)itemAtIndex:(NSUInteger)index;

/**
 *  If the selection rule is SelectionRuleOnlyOne, the index of item currently selected.
 */
@property (nonatomic, assign, readonly) NSUInteger      itemSelectedIndex;

/**
 *  Return the number of item in the section.
 *
 *  @return The number of item.
 */
- (NSUInteger)numberOfItems;

/**
 *  Select an item.
 *
 *  If the selection rule is set to SelectionRuleNone, the selected action of the item will be called.
 *  If the selection rule is set to SelectionRuleOnlyOne, the new cell will be checked and the others will be unchecked. The corresponding actions will also be called.
 *  If the selection rule is set to SelectionRuleMultiple, the new cell will be checked / unchecked and the corresponding action will be called.
 *
 *  @param index The index.
 */
- (void)selectItemAtIndex:(NSUInteger)index;

@end