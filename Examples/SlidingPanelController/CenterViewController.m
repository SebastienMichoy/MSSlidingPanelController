//
//  CenterViewController.m
//  SlidingPanelController
//
//  Created by Sébastien MICHOY on 12/13/13.
//  Copyright (c) 2013 Sébastien MICHOY. All rights reserved.
//

#import "CenterViewController.h"
#import "Color.h"
#import "LeftPanelViewController.h"
#import "MSViewControllerSlidingPanel.h"
#import "NavigationBarButton.h"
#import "RightPanelViewController.h"
#import "TableViewItem.h"
#import "TableViewSection.h"

#pragma mark - Global variables

/**
 *  Cells' identifier.
 */
NSString    *g_CVCCellIdentifier = @"CellIdentifier";

#pragma mark - Interface

@interface CenterViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark Properties
/** @name Properties */

@property (nonatomic, strong)   NSArray *sections;

#pragma mark Filling sections
/** @name Filling sections */

/**
 *  Create and return a new section to change controller.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionChangeControllers;

/**
 *  Create and return a new section to choose if the left panel status bar must be displayed smoothly.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelStatusBarDisplayedSmoothly;

/**
 *  Create and return a new section to open and close the panels.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionOpenClosePanels;

/**
 *  Create and return a new section to choose if the right panel status bar must be displayed smoothly.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionRightPanelStatusBarDisplayedSmoothly;

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

#pragma mark Menu buttons
/** @name Menu buttons */

/**
 *  The left button of the navigation bar.
 */
@property (nonatomic, strong)   NavigationBarButton *menuButtonLeft;

/**
 *  the right button of the navigation bar.
 */
@property (nonatomic, strong)   NavigationBarButton *menuButtonRight;

@end

#pragma mark - Implementation

@implementation CenterViewController

#pragma Initialization
/** @name Initialization */

/**
 *  Initialize and return a new sliding panel controller.
 *
 *  @param nibNameOrNil   The nib name or nil.
 *  @param nibBundleOrNil The bundle name or nil.
 *
 *  @return The initialized centrer view controller.
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
    UINavigationBar     *navigationBar;
    UINavigationItem    *navigationBarItem;
    UITableView         *tableView;
    UILabel             *tableViewFooter;
    CGSize              windowSize;
    
    [super loadView];
    
    windowSize = [[UIScreen mainScreen] bounds].size;
    
    [self setMenuButtonLeft:[NavigationBarButton buttonWithType:NavigationBarButtonTypeMenu]];
    [[self menuButtonLeft] setTarget:[self slidingPanelController]];
    
    if ([[self slidingPanelController] sideDisplayed] == MSSPSideDisplayedLeft)
        [[self menuButtonLeft] setAction:@selector(closePanel)];
    else
        [[self menuButtonLeft] setAction:@selector(openLeftPanel)];
    
    [self setMenuButtonRight:[NavigationBarButton buttonWithType:NavigationBarButtonTypeMenu]];
    [[self menuButtonRight] setTarget:[self slidingPanelController]];
    
    if ([[self slidingPanelController] sideDisplayed] == MSSPSideDisplayedRight)
        [[self menuButtonRight] setAction:@selector(closePanel)];
    else
        [[self menuButtonRight] setAction:@selector(openRightPanel)];
    
    navigationBarItem = [[UINavigationItem alloc] initWithTitle:@"Sliding panel"];
    [navigationBarItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[self menuButtonLeft]]];
    [navigationBarItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[self menuButtonRight]]];
    
    navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, windowSize.width, 44)];
    [navigationBar setBarTintColor:[UIColor centerNavBarBackgroundColor]];
    [navigationBar pushNavigationItem:navigationBarItem animated:NO];
    [navigationBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    tableViewFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, 20)];
    [tableViewFooter setText:@"Developped by Sébastien MICHOY."];
    [tableViewFooter setTextAlignment:NSTextAlignmentCenter];
    [tableViewFooter setFont:[UIFont italicSystemFontOfSize:10]];
    [tableViewFooter setTextColor:[UIColor darkGrayColor]];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, windowSize.width, windowSize.height - 64)];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:g_CVCCellIdentifier];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setTableFooterView:tableViewFooter];
    [tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    [self setView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)]];
    [[self view] setBackgroundColor:[UIColor centerBackgroundColor]];
    [[self view] addSubview:navigationBar];
    [[self view] addSubview:tableView];
}

#pragma mark Filling sections
/** @name Filling sections */

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
 *  Create and return a new section to choose if the left panel status bar must be displayed smoothly.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionLeftPanelStatusBarDisplayedSmoothly
{
    TableViewItem       *itemYes;
    TableViewItem       *itemNo;
    TableViewSection    *section;
    
    itemYes = [TableViewItem tableViewItemCheckableWithName:@"Yes"];
    [itemYes setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelStatusBarDisplayedSmoothly:YES];}];
    
    itemNo = [TableViewItem tableViewItemCheckableWithName:@"No"];
    [itemNo setChecked:YES];
    [itemNo setActionWhenSelected:^(void){[[self slidingPanelController] setLeftPanelStatusBarDisplayedSmoothly:NO];}];
    
    section = [TableViewSection tableViewSectionWitName:@"DISPLAY LEFT STATUS BAR SMOOTHLY"
                                          selectionRule:SelectionRuleOnlyOne
                                               andItems:itemYes,
                                                        itemNo,
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
    TableViewItem       *itemOpenLeft;
    TableViewItem       *itemOpenRight;
    TableViewItem       *itemClosePanel;
    TableViewSection    *section;
    
    itemOpenLeft = [TableViewItem tableViewItemUncheckableWithName:@"Open left panel"];
    [itemOpenLeft setActionWhenSelected:^(void){[[self slidingPanelController] openLeftPanel];}];
    
    itemOpenRight = [TableViewItem tableViewItemUncheckableWithName:@"Open right panel"];
    [itemOpenRight setActionWhenSelected:^(void){[[self slidingPanelController] openRightPanel];}];
    
    itemClosePanel = [TableViewItem tableViewItemUncheckableWithName:@"Close panel"];
    [itemClosePanel setActionWhenSelected:^(void){[[self slidingPanelController] closePanel];}];
    
    section = [TableViewSection tableViewSectionWitName:@"OPEN/CLOSE PANELS"
                                          selectionRule:SelectionRuleNone
                                               andItems:itemOpenLeft,
                                                        itemOpenRight,
                                                        itemClosePanel,
                                                        nil];
    
    return (section);
}

/**
 *  Create and return a new section to choose if the right panel status bar must be displayed smoothly.
 *
 *  @return Return a section filled.
 */
- (TableViewSection *)fillingSectionRightPanelStatusBarDisplayedSmoothly
{
    TableViewItem       *itemYes;
    TableViewItem       *itemNo;
    TableViewSection    *section;
    
    itemYes = [TableViewItem tableViewItemCheckableWithName:@"Yes"];
    [itemYes setActionWhenSelected:^(void){[[self slidingPanelController] setRightPanelStatusBarDisplayedSmoothly:YES];}];
    
    itemNo = [TableViewItem tableViewItemCheckableWithName:@"No"];
    [itemNo setChecked:YES];
    [itemNo setActionWhenSelected:^(void){[[self slidingPanelController] setRightPanelStatusBarDisplayedSmoothly:NO];}];
    
    section = [TableViewSection tableViewSectionWitName:@"DISPLAY RIGHT STATUS BAR SMOOTHLY"
                                          selectionRule:SelectionRuleOnlyOne
                                               andItems:itemYes,
                                                        itemNo,
                                                        nil];
    
    return (section);
}

/**
 *  Create all the sections and register them.
 */
- (void)fillingSections
{
    NSArray *sections;
    
    sections = [[NSArray alloc] initWithObjects:[self fillingSectionLeftPanelStatusBarDisplayedSmoothly],
                                                [self fillingSectionRightPanelStatusBarDisplayedSmoothly],
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
    
    if ([indexPath section] >= [[self sections] count])
        return (nil);
    
    section = [[self sections] objectAtIndex:[indexPath section]];
    
    if ([indexPath row] >= [section numberOfItems])
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
    if (index >= [[self sections] count])
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    
    cell = [tableView dequeueReusableCellWithIdentifier:g_CVCCellIdentifier];
    item = [self itemAtIndexPath:indexPath];
    
    [[cell textLabel] setText:[item name]];
        
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ([[self sectionAtIndex:section] name]);
}

#pragma mark UITableViewDelegate protocol
/** @name UITableViewDelegate protocol */

/**
 *  Called when a section will be displayed.
 *
 *  @param tableView The table view.
 *  @param view      The section view.
 *  @param section   The section number.
 */
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    [[(UITableViewHeaderFooterView *)view contentView] setBackgroundColor:[UIColor centerTableViewSectionBackgroundColor]];
}

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

#pragma mark MSSlidingPanelControllerDelegate protocol
/** @name MSSlidingPanelControllerDelegate protocol */

/**
 *  Tells the delegate that the specified side begins to bring out.
 *
 *  @param panelController The panel controller.
 *  @param side            The side.
 */
- (void)slidingPanelController:(MSSlidingPanelController *)panelController beginsToBringOutSide:(MSSPSideDisplayed)side
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

/**
 *  Tells the delegate that the specified side has been closed.
 *
 *  @param panelController The panel controller.
 *  @param side            The side.
 */
- (void)slidingPanelController:(MSSlidingPanelController *)panelController hasClosedSide:(MSSPSideDisplayed)side
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (side == MSSPSideDisplayedLeft)
        [[self menuButtonLeft] setAction:@selector(openLeftPanel)];
    else
        [[self menuButtonRight] setAction:@selector(openRightPanel)];
}

/**
 *  Tells the delegate that the specified side has been opened.
 *
 *  @param panelController The panel controller.
 *  @param side            The side.
 */
- (void)slidingPanelController:(MSSlidingPanelController *)panelController hasOpenedSide:(MSSPSideDisplayed)side
{
    if (side == MSSPSideDisplayedLeft)
        [[self menuButtonLeft] setAction:@selector(closePanel)];
    else
        [[self menuButtonRight] setAction:@selector(closePanel)];
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
