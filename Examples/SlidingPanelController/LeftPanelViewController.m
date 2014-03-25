//  LeftPanelViewController.m
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

#import "CenterViewController.h"
#import "Color.h"
#import "LeftPanelViewController.h"
#import "MSViewControllerSlidingPanel.h"
#import "RightPanelViewController.h"
#import "TableViewItem.h"
#import "TableViewSection.h"

#pragma mark - Global variables

/**
 *  Cells' identifier.
 */
NSString    *g_LPVCCellIdentifier = @"CellIdentifier";

#pragma mark - LeftPanelViewController interface

@interface LeftPanelViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark Properties
/** @name Properties */

@property (nonatomic, strong)   NSArray *sections;

#pragma mark Filling sections
/** @name Filling sections */

/**
 *  Create and return a new section about the interaction mode.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionCenterViewInteractionMode;

/**
 *  Create and return a new section to change controller.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionChangeControllers;

/**
 *  Create and return a new section about the left panel width.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelWidth;

/**
 *  Create and return a new section about the left panel close gestures.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelCloseGestures;

/**
 *  Create and return a new section about the left panel open gestures.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelOpenGestures;

/**
 *  Create and return a new section to open and close the panels.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionOpenClosePanels;

/**
 *  Create all the sections and register them.
 */
- (void)fillingSections;

#pragma mark Getting table view sections and items
/** @name Getting table view sections and items */

/**
 *  Return the item at the index path.
 *
 *  @param indexPath The index path.
 *
 *  @return The item.
 */
- (TableViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Return the section at the index.
 *
 *  @param index The index.
 *
 *  @return The section.
 */
- (TableViewSection *)sectionAtIndex:(NSInteger)index;

#pragma mark Tool
/** @name Tool */

/**
 *  Reset the default panel values.
 *
 *  @param side The side on which the values must be applied.
 */
- (void)resetDefaultPanelValuesForSide:(MSSPSideDisplayed)side;

@end

#pragma mark - LeftPanelViewController implementation

@implementation LeftPanelViewController

#pragma mark Initilization
/** @name Initilization */

/**
 *  Initialize and return a left panel view.
 *
 *  @param nibNameOrNil   The nib name or nil.
 *  @param nibBundleOrNil The bundle name or nil.
 *
 *  @return The initialized left panel view.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self fillingSections];
    }
    
    return (self);
}

#pragma mark View life cycle
/** @name View life cycle */

/**
 *  Creates the view that the controller manages.
 */
- (void)loadView
{
    UITableView *tableView;
    CGSize      windowSize;
    
    windowSize = [[UIScreen mainScreen] bounds].size;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, windowSize.width, windowSize.height - 20)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:g_LPVCCellIdentifier];
    [tableView setTableFooterView:[[UIView alloc] init]];
    [tableView setBackgroundColor:[UIColor menuBackgroundColor]];
    [tableView setSeparatorColor:[UIColor menuTableViewSeparatorsColor]];
    [tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    [self setView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)]];
    [[self view] addSubview:tableView];
}

#pragma mark Filling sections
/** @name Filling sections */

/**
 *  Create and return a new section about the interaction mode.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionCenterViewInteractionMode
{
    TableViewItem       *itemFullView;
    TableViewItem       *itemNavBar;
    TableViewItem       *itemNone;
    TableViewSection    *section;
    
    itemFullView = [TableViewItem tableViewItemCheckableWithName:@"Full view"];
    [itemFullView setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelCenterViewInteractionMode:MSSPCenterViewInteractionFullView];}];
    
    itemNavBar = [TableViewItem tableViewItemCheckableWithName:@"Nav bar"];
    [itemNavBar setChecked:YES];
    [itemNavBar setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelCenterViewInteractionMode:MSSPCenterViewInteractionNavBar];}];
    
    itemNone = [TableViewItem tableViewItemCheckableWithName:@"None"];
    [itemNone setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelCenterViewInteractionMode:MSSPCenterViewInteractionNone];}];
    
    section = [TableViewSection tableViewSectionWitName:@"CENTER VIEW INTERACTION MODE"
                                          selectionRule:SelectionRuleOnlyOne
                                               andItems:itemFullView,
                                                        itemNavBar,
                                                        itemNone,
                                                        nil];
    
    return (section);
}

/**
 *  Create and return a new section to change controller.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionChangeControllers
{
    TableViewItem       *itemChangeCenterView;
    TableViewItem       *itemChangeLeftPanel;
    TableViewItem       *itemChangeRightPanel;
    TableViewItem       *itemRemoveLeftPanel;
    TableViewItem       *itemRemoveRightPanel;
    TableViewSection    *section;
    
    itemChangeCenterView = [TableViewItem tableViewItemUncheckableWithName:@"Change center view"];
    [itemChangeCenterView setActionWhenSelected:^(void)
     {
         CenterViewController    *centerViewController;
         
         [self resetDefaultPanelValuesForSide:MSSPSideDisplayedNone];
         
         centerViewController = [[CenterViewController alloc] initWithNibName:nil bundle:nil];
         [[self slidingPanelController] setDelegate:centerViewController];
         [[self slidingPanelController] setCenterViewController:centerViewController];
     }];
    
    itemChangeLeftPanel = [TableViewItem tableViewItemUncheckableWithName:@"Change left panel"];
    [itemChangeLeftPanel setActionWhenSelected:^(void)
     {
         [self resetDefaultPanelValuesForSide:MSSPSideDisplayedLeft];
         [[self slidingPanelController] setLeftPanelController:[[LeftPanelViewController alloc] initWithNibName:nil bundle:nil]];
     }];
    
    itemChangeRightPanel = [TableViewItem tableViewItemUncheckableWithName:@"Change right panel"];
    [itemChangeRightPanel setActionWhenSelected:^(void)
     {
         [self resetDefaultPanelValuesForSide:MSSPSideDisplayedRight];
         [[self slidingPanelController] setRightPanelController:[[RightPanelViewController alloc] initWithNibName:nil bundle:nil]];
     }];
    
    itemRemoveLeftPanel = [TableViewItem tableViewItemUncheckableWithName:@"Remove left panel"];
    [itemRemoveLeftPanel setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelController:nil];}];
    
    itemRemoveRightPanel = [TableViewItem tableViewItemUncheckableWithName:@"Remove right panel"];
    [itemRemoveRightPanel setActionWhenSelected:^(void){[[self slidingPanelController] setRightPanelController:nil];}];
    
    section = [TableViewSection tableViewSectionWitName:@"CHANGE CONTROLLERS"
                                          selectionRule:SelectionRuleNone
                                               andItems:itemChangeCenterView,
               itemChangeLeftPanel,
               itemChangeRightPanel,
               itemRemoveLeftPanel,
               itemRemoveRightPanel,
               nil];
    
    return (section);
}

/**
 *  Create and return a new section about the left panel width.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelWidth
{
    TableViewItem       *item160;
    TableViewItem       *item200;
    TableViewItem       *item240;
    TableViewItem       *item280;
    TableViewItem       *item320;
    TableViewSection    *section;
    
    item160 = [TableViewItem tableViewItemCheckableWithName:@"160 pts"];
    [item160 setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelMaximumWidth:160];}];
    
    item200 = [TableViewItem tableViewItemCheckableWithName:@"200 pts"];
    [item200 setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelMaximumWidth:200];}];
    
    item240 = [TableViewItem tableViewItemCheckableWithName:@"240 pts"];
    [item240 setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelMaximumWidth:240];}];
    
    item280 = [TableViewItem tableViewItemCheckableWithName:@"280 pts"];
    [item280 setChecked:YES];
    [item280 setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelMaximumWidth:280];}];
    
    item320 = [TableViewItem tableViewItemCheckableWithName:@"320 pts"];
    [item320 setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelMaximumWidth:320];}];
    
    section = [TableViewSection tableViewSectionWitName:@"LEFT PANEL WIDTH"
                                          selectionRule:SelectionRuleOnlyOne
                                               andItems:item160,
                                                        item200,
                                                        item240,
                                                        item280,
                                                        item320,
                                                        nil];
    
    return (section);
}

/**
 *  Create and return a new section about the left panel close gestures.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelCloseGestures
{
    TableViewItem       *itemDraggingContent;
    TableViewItem       *itemDraggingNavBar;
    TableViewItem       *itemTapContent;
    TableViewItem       *itemTapNavBar;
    TableViewSection    *section;
    
    itemDraggingNavBar = [TableViewItem tableViewItemCheckableWithName:@"Dragging nav bar"];
    [itemDraggingNavBar setChecked:YES];
    [itemDraggingNavBar setActionWhenSelected:^(void){[self slidingPanelController].leftPanelCloseGestureMode |= MSSPCloseGestureModePanNavBar;}];
    [itemDraggingNavBar setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelCloseGestureMode &= (MSSPCloseGestureModePanNavBar ^ MSSPCloseGestureModeAll);}];
    
    itemDraggingContent = [TableViewItem tableViewItemCheckableWithName:@"Dragging content"];
    [itemDraggingContent setChecked:YES];
    [itemDraggingContent setActionWhenSelected:^(void){[self slidingPanelController].leftPanelCloseGestureMode |= MSSPCloseGestureModePanContent;}];
    [itemDraggingContent setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelCloseGestureMode &= (MSSPCloseGestureModePanContent ^ MSSPCloseGestureModeAll);}];
    
    itemTapNavBar = [TableViewItem tableViewItemCheckableWithName:@"Tap nav bar"];
    [itemTapNavBar setChecked:YES];
    [itemTapNavBar setActionWhenSelected:^(void){[self slidingPanelController].leftPanelCloseGestureMode |= MSSPCloseGestureModeTapNavBar;}];
    [itemTapNavBar setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelCloseGestureMode &= (MSSPCloseGestureModeTapNavBar ^ MSSPCloseGestureModeAll);}];
    
    itemTapContent = [TableViewItem tableViewItemCheckableWithName:@"Tap content"];
    [itemTapContent setChecked:YES];
    [itemTapContent setActionWhenSelected:^(void){[self slidingPanelController].leftPanelCloseGestureMode |= MSSPCloseGestureModeTapContent;}];
    [itemTapContent setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelCloseGestureMode &= (MSSPCloseGestureModeTapContent ^ MSSPCloseGestureModeAll);}];
    
    section = [TableViewSection tableViewSectionWitName:@"LEFT PANEL CLOSE GESTURES"
                                          selectionRule:SelectionRuleMultiple
                                               andItems:itemDraggingNavBar,
                                                        itemDraggingContent,
                                                        itemTapNavBar,
                                                        itemTapContent,
                                                        nil];
    
    return (section);
}

/**
 *  Create and return a new section about the left panel open gestures.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelOpenGestures
{
    TableViewItem       *itemDraggingContent;
    TableViewItem       *itemDraggingNavBar;
    TableViewSection    *section;
    
    itemDraggingNavBar = [TableViewItem tableViewItemCheckableWithName:@"Dragging nav bar"];
    [itemDraggingNavBar setChecked:YES];
    [itemDraggingNavBar setActionWhenSelected:^(void){[self slidingPanelController].leftPanelOpenGestureMode |= MSSPOpenGestureModePanNavBar;}];
    [itemDraggingNavBar setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelOpenGestureMode &= (MSSPOpenGestureModePanNavBar ^ MSSPOpenGestureModeAll);}];
    
    itemDraggingContent = [TableViewItem tableViewItemCheckableWithName:@"Dragging content"];
    [itemDraggingContent setChecked:YES];
    [itemDraggingContent setActionWhenSelected:^(void){[self slidingPanelController].leftPanelOpenGestureMode |= MSSPOpenGestureModePanContent;}];
    [itemDraggingContent setActionWhenDeselected:^(void){[self slidingPanelController].leftPanelOpenGestureMode &= (MSSPOpenGestureModePanContent ^ MSSPOpenGestureModeAll);}];
    
    section = [TableViewSection tableViewSectionWitName:@"LEFT PANEL OPEN GESTURES"
                                          selectionRule:SelectionRuleMultiple
                                               andItems:itemDraggingNavBar,
                                                        itemDraggingContent,
                                                        nil];
    
    return (section);
}

/**
 *  Create and return a new section to open and close the panels.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionOpenClosePanels
{
    TableViewItem       *itemCloseLeft;
    TableViewItem       *itemOpenRight;
    TableViewSection    *section;
    
    itemCloseLeft = [TableViewItem tableViewItemUncheckableWithName:@"Close left panel"];
    [itemCloseLeft setActionWhenSelected:^(void){[[self slidingPanelController] closePanel];}];
    
    itemOpenRight = [TableViewItem tableViewItemUncheckableWithName:@"Open right panel"];
    [itemOpenRight setActionWhenSelected:^(void){[[self slidingPanelController] openRightPanel];}];
    
    section = [TableViewSection tableViewSectionWitName:@"OPEN/CLOSE PANELS"
                                          selectionRule:SelectionRuleNone
                                               andItems:itemCloseLeft,
                                                        itemOpenRight,
                                                        nil];
    
    return (section);
}

/**
 *  Create all the sections and register them.
 */
- (void)fillingSections
{
    NSArray *sections;
    
    sections = [[NSArray alloc] initWithObjects:[self fillingSectionLeftPanelWidth],
                                                [self fillingSectionLeftPanelOpenGestures],
                                                [self fillingSectionLeftPanelCloseGestures],
                                                [self fillingSectionCenterViewInteractionMode],
                                                [self fillingSectionChangeControllers],
                                                [self fillingSectionOpenClosePanels],
                                                nil];
    
    [self setSections:sections];
}

#pragma mark Getting table view sections and items
/** @name Getting table view sections and items */

/**
 *  Return the item at the index path.
 *
 *  @param indexPath The index path.
 *
 *  @return The item.
 */
- (TableViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewSection    *section;
    
    if ((NSUInteger)[indexPath section] >= [[self sections] count])
        return (nil);
    
    section = [[self sections] objectAtIndex:[indexPath section]];
    
    if ((NSUInteger)[indexPath row] >= [section numberOfItems])
        return nil;
    
    return ([section itemAtIndex:[indexPath row]]);
}

/**
 *  Return the section at the index.
 *
 *  @param index The index.
 *
 *  @return The section.
 */
- (TableViewSection *)sectionAtIndex:(NSInteger)index
{
    if ((NSUInteger)index >= [[self sections] count])
        return (nil);
    
    return ([[self sections] objectAtIndex:index]);
}

#pragma mark UITableViewDataSource protocol
/** @name UITableViewDataSource protocol */

/**
 *  Give the number of sections in a table view.
 *
 *  @param tableView The table view.
 *
 *  @return The number of values.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return ([[self sections] count]);
}

/**
 *  Return the cell for the index path in the table view.
 *
 *  @param tableView The table view.
 *  @param indexPath The index path.
 *
 *  @return The cell.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    TableViewItem   *item;
    
    cell = [tableView dequeueReusableCellWithIdentifier:g_LPVCCellIdentifier];
    item = [self itemAtIndexPath:indexPath];
    
    [[cell textLabel] setText:[item name]];
    
    [cell setBackgroundColor:[UIColor menuTableViewCellBackgroundColor]];
    [[cell textLabel] setTextColor:[UIColor menuTableViewCellTextColor]];
    [cell setSelectedBackgroundView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [cell frame].size.width, [cell frame].size.height)]];
    [[cell selectedBackgroundView] setBackgroundColor:[UIColor menuTableViewCellBackgroundSelectedColor]];
    
    if ([[self sectionAtIndex:[indexPath section]] selectionRule] == SelectionRuleNone)
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    else
    {
        if ([item checked])
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        else
            [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return (cell);
}

/**
 *  Return the number of rows in a section of a table view.
 *
 *  @param tableView The table view.
 *  @param section   The section number.
 *
 *  @return The number of rows.
 */
- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)section
{
    return ([[self sectionAtIndex:section] numberOfItems]);
}

/**
 *  Return the title of the header of a section.
 *
 *  @param tableView The table view.
 *  @param section   The section number.
 *
 *  @return The title.
 */
- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)section
{
    return ([[self sectionAtIndex:section] name]);
}

#pragma mark UITableViewDelegate protocol
/** @name UITableViewDelegate protocol */

/**
 *  Called when a cell will be selected.
 *
 *  @param tableView The table view.
 *  @param indexPath The cell's index path.
 *
 *  @return The indexpath of the cell which must be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath         *tmpIndexPath;
    TableViewSection    *section;
 
    section = [self sectionAtIndex:[indexPath section]];
    
    if ([section selectionRule] == SelectionRuleNone)
        [section selectItemAtIndex:[indexPath row]];
    else if ([section selectionRule] == SelectionRuleOnlyOne)
    {
        tmpIndexPath = [NSIndexPath indexPathForRow:[section itemSelectedIndex] inSection:[indexPath section]];
        [[tableView cellForRowAtIndexPath:tmpIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
        [section selectItemAtIndex:[indexPath row]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [section selectItemAtIndex:[indexPath row]];
        
        if ([[section itemAtIndex:[indexPath row]] checked])
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        else
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return (nil);
}

#pragma mark Tool
/** @name Tool */

/**
 *  Reset the default panel values.
 *
 *  @param side The side on which the values must be applied.
 */
- (void)resetDefaultPanelValuesForSide:(MSSPSideDisplayed)side
{
    if (side == MSSPSideDisplayedLeft)
    {
        [[self slidingPanelController] setLeftPanelMaximumWidth:280];
        [[self slidingPanelController] setLeftPanelOpenGestureMode:MSSPOpenGestureModeAll];
        [[self slidingPanelController] setLeftPanelCloseGestureMode:MSSPCloseGestureModeAll];
        [[self slidingPanelController] setLeftPanelCenterViewInteractionMode:MSSPCenterViewInteractionNavBar];
    }
    else if (side == MSSPSideDisplayedRight)
    {
        [[self slidingPanelController] setRightPanelMaximumWidth:280];
        [[self slidingPanelController] setRightPanelOpenGestureMode:MSSPOpenGestureModeAll];
        [[self slidingPanelController] setRightPanelCloseGestureMode:MSSPCloseGestureModeAll];
        [[self slidingPanelController] setRightPanelCenterViewInteractionMode:MSSPCenterViewInteractionNavBar];
    }
    else
    {
        [[self slidingPanelController] setLeftPanelStatusBarDisplayedSmoothly:NO];
        [[self slidingPanelController] setRightPanelStatusBarDisplayedSmoothly:NO];
    }
}

@end
