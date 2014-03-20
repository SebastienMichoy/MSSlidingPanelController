//  TableViewSection.h
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