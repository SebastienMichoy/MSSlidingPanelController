//
//  TableViewSection.m
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 28/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "TableViewSection.h"

#pragma mark - Interface

@interface TableViewSection ()

#pragma mark Items
/** @name Items */

/**
 *  The section's items.
 */
@property (nonatomic, strong)   NSMutableArray  *items;

/**
 *  If the selection rule is SelectionRuleOnlyOne, the item currently selected.
 */
@property (nonatomic, weak)     TableViewItem   *itemSelected;

/**
 *  If the selection rule is SelectionRuleOnlyOne, the index of item currently selected.
 */
@property (nonatomic, assign)   NSUInteger      itemSelectedIndex;

#pragma mark Section information
/** @name Section information */

/**
 *  The section's selection rule.
 */
@property (nonatomic, assign)   SelectionRule   selectionRule;

@end

#pragma mark - Implementation

@implementation TableViewSection

#pragma mark Initialization
/** @name Initialization */

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setName:@""];
        [self setSelectionRule:SelectionRuleNone];
        [self setItemSelected:nil];
        [self setItemSelectedIndex:0];
        [self setItems:[[NSMutableArray alloc] init]];
    }
    
    return (self);
}

/**
 *  Create and return a `TableViewSection` object.
 *
 *  @param name          The section's name. It must not be `nil`.
 *  @param selectionRule The section's selection rule.
 *  @param items         The items, ended by nil. The incompatible items will dropped.
 *
 *  @return The `UITableViewSection` object.
 */
+ (TableViewSection *)tableViewSectionWitName:(NSString *)name selectionRule:(SelectionRule)selectionRule andItems:(TableViewItem *)items, ...
{
    NSUInteger          i;
    TableViewItem       *item;
    va_list             itemsList;
    TableViewSection    *section;
    
    NSParameterAssert(name);
    
    section = [[TableViewSection alloc] init];
    [section setName:name];
    [section setSelectionRule:selectionRule];
    
    va_start(itemsList, items);
    for (item = items, i = 0; item; item = va_arg(itemsList, TableViewItem *), i++)
    {
        if (([section selectionRule] == SelectionRuleNone && ![item isCheckable]) ||
            ([section selectionRule] != SelectionRuleNone && [item isCheckable]))
        {
            if ([section selectionRule] == SelectionRuleOnlyOne && [item checked])
            {
                if ([section itemSelected])
                    [[section itemSelected] setChecked:NO];
                
                [section setItemSelected:item];
                [section setItemSelectedIndex:i];
            }
            
            [[section items] addObject:item];
        }
    }
    va_end(itemsList);
    
    if ([section selectionRule] == SelectionRuleOnlyOne && ![section itemSelected] && [section numberOfItems] > 0)
    {
        [section setItemSelected:[[section items] objectAtIndex:0]];
        [section setItemSelectedIndex:0];
        [[section itemSelected] setChecked:YES];
    }
    
    return (section);
}

#pragma mark Manage items
/** @name Manage items */

/**
 *  Return a copy of the item at the index.
 *
 *  @param index The index.
 *
 *  @return A copy of the item. Is nil if the index is out of bounds.
 */
- (TableViewItem *)itemAtIndex:(NSUInteger)index
{
    if (index >= [self numberOfItems])
        return (nil);
    
    return ([[[self items] objectAtIndex:index] copy]);
}

/**
 *  Return the number of item in the section.
 *
 *  @return The number of item.
 */
- (NSUInteger)numberOfItems
{
    return ([[self items] count]);
}

/**
 *  Select an item.
 *
 *  If the selection rule is set to SelectionRuleNone, the selected action of the item will be called.
 *  If the selection rule is set to SelectionRuleOnlyOne, the new cell will be checked and the others will be unchecked. The corresponding actions will also be called.
 *  If the selection rule is set to SelectionRuleMultiple, the new cell will be checked / unchecked and the corresponding action will be called.
 *
 *  @param index The index.
 */
- (void)selectItemAtIndex:(NSUInteger)index
{
    if (index >= [self numberOfItems])
        return ;
    
    if ([self selectionRule] == SelectionRuleNone)
        [[[self items] objectAtIndex:index] actionWhenSelected]();
    else if ([self selectionRule] == SelectionRuleOnlyOne)
    {
        if ([[[self items] objectAtIndex:index] checked])
            return ;
        
        if ([self itemSelected])
        {
            [[self itemSelected] setChecked:NO];
            
            if ([[self itemSelected] actionWhenDeselected])
                [[self itemSelected] actionWhenDeselected]();
        }
        
        [[[self items] objectAtIndex:index] setChecked:YES];
        [self setItemSelected:[[self items] objectAtIndex:index]];
        [self setItemSelectedIndex:index];
        
        if ([[[self items] objectAtIndex:index] actionWhenSelected])
            [[[self items] objectAtIndex:index] actionWhenSelected]();
    }
    else
    {
        if ([[[self items] objectAtIndex:index] checked])
        {
            [[[self items] objectAtIndex:index] setChecked:NO];
            
            if ([[[self items] objectAtIndex:index] actionWhenDeselected])
                [[[self items] objectAtIndex:index] actionWhenDeselected]();
        }
        else
        {
            [[[self items] objectAtIndex:index] setChecked:YES];
            
            if ([[[self items] objectAtIndex:index] actionWhenSelected])
                [[[self items] objectAtIndex:index] actionWhenSelected]();
        }
    }
}

@end
