//
//  TableViewItem.m
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 28/11/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "TableViewItem.h"

#pragma mark - Interface

@interface TableViewItem ()

#pragma mark Item properties
/** @name Item properties */

/**
 *  Indicate if the item is checkable.
 */
@property (nonatomic, assign)   BOOL    isCheckable;

@end

#pragma mark - Implementation

@implementation TableViewItem

#pragma mark Initialization
/** @name Initialization */

/**
 *  Create and return a `TableViewItem` object.
 *
 *  @return The `TableViewItem` object.
 */
- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setName:@""];
        [self setIsCheckable:NO];
        [self setChecked:NO];
    }
    
    return (self);
}

/**
 *  Create and return a checkable `TableViewItem` object.
 *
 *  @param name       The item's name. It must not be `nil`.
 *
 *  @return The `TableViewItem` object.
 */
+ (TableViewItem *)tableViewItemCheckableWithName:(NSString *)name
{
    TableViewItem   *item;
    
    NSParameterAssert(name);
    
    item = [[TableViewItem alloc] init];
    [item setName:name];
    [item setIsCheckable:YES];

    return (item);
}

/**
 *  Create and return a uncheckable `TableViewItem` object.
 *
 *  @param name The item's name. It must not be `nil`.
 *
 *  @return The `TableViewItem` object.
 */
+ (TableViewItem *)tableViewItemUncheckableWithName:(NSString *)name
{
    TableViewItem   *item;
    
    NSParameterAssert(name);
    
    item = [[TableViewItem alloc] init];
    [item setName:name];
    
    return (item);
}

#pragma mark Copy
/** @name Copy */

- (id)copyWithZone:(NSZone *)zone
{
    TableViewItem   *item;
    
    item = [[TableViewItem alloc] init];
    [item setActionWhenDeselected:[self actionWhenDeselected]];
    [item setActionWhenSelected:[self actionWhenSelected]];
    [item setChecked:[self checked]];
    [item setIsCheckable:[self isCheckable]];
    [item setName:[self name]];
    
    return (item);
}

@end
