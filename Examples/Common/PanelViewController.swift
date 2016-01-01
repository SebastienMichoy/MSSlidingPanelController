//
//  PanelViewController.swift
//
//  Copyright © 2016-present Sébastien MICHOY and contributors.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer. Redistributions in binary
//  form must reproduce the above copyright notice, this list of conditions and
//  the following disclaimer in the documentation and/or other materials
//  provided with the distribution. Neither the name of the Sébastien MICHOY
//  nor the names of its contributors may be used to endorse or promote
//  products derived from this software without specific prior written
//  permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

class PanelViewController: UIViewController {

    // MARK: Type alias
    
    private typealias Item = (title: String, checkmarked: Bool, tappedClosure: ItemTappedClosure?)
    private typealias ItemTappedClosure = (Void) -> Void
    
    // MARK: Sections & Items
    
    private enum Section {
        case PanelWidth
        case Animation
        case StatusBar
        case OpeningGestures
        case ClosingGestures
        case CenterViewInteraction
        case Actions
        case ResetViews
        
        private var items: [Item] {
            switch self {
            case .PanelWidth:
                return panelWidthItems
            case .Animation:
                return animationItems
            case .StatusBar:
                return statusBarItems
            case .OpeningGestures:
                return openingGesturesItems
            case .ClosingGestures:
                return closingGesturesItems
            case .CenterViewInteraction:
                return centerViewInteractionItems
            case .Actions:
                return actionsItems
            case .ResetViews:
                return resetViewsItems
            }
        }
        
        private var actionsItems: [Item] {
            let topPanelText: String
            let leftPanelText: String
            let rightPanelText: String
            let bottomPanelText: String
            
            topPanelText = NSString(format: NSLocalizedString("common_panel_action"), NSLocalizedString("common_open"), NSLocalizedString("common_top_panel")).capitalizedString as String
            leftPanelText = NSString(format: NSLocalizedString("common_panel_action"), NSLocalizedString("common_open"), NSLocalizedString("common_left_panel")).capitalizedString as String
            rightPanelText = NSString(format: NSLocalizedString("common_panel_action"), NSLocalizedString("common_open"), NSLocalizedString("common_right_panel")).capitalizedString as String
            bottomPanelText = NSString(format: NSLocalizedString("common_panel_action"), NSLocalizedString("common_open"), NSLocalizedString("common_bottom_panel")).capitalizedString as String
            
            return [(topPanelText, false, nil),
                    (leftPanelText, false, nil),
                    (rightPanelText, false, nil),
                    (bottomPanelText, false, nil)]
        }
        
        private var animationItems: [Item] {
            return [(NSLocalizedString("panel_view_section_animation_center_sliding").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_animation_panel_sliding").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_animation_None").capitalizedString, false, nil)]
        }
        
        private var centerViewInteractionItems: [Item] {
            return [(NSLocalizedString("panel_view_section_center_view_interaction_entire_view").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_center_view_interaction_nav_bar_only").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_center_view_interaction_none").capitalizedString, false, nil)]
        }
        
        private var closingGesturesItems: [Item] {
            return [(NSLocalizedString("panel_view_section_closing_gestures_dragging_nav_bar").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_closing_gestures_dragging_content").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_closing_gestures_tap_nav_bar").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_closing_gestures_tap_content").capitalizedString, false, nil)]
        }
        
        private var numberOfItems: Int {
            return self.items.count
        }
        
        private var openingGesturesItems: [Item] {
            return [(NSLocalizedString("panel_view_section_opening_gestures_dragging_nav_bar").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_opening_gestures_dragging_content").capitalizedString, false, nil)]
        }
        
        private var panelWidthItems: [Item] {
            return [(NSLocalizedString("panel_view_section_panel_width_100").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_panel_width_75").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_panel_width_50").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_panel_width_25").capitalizedString, false, nil)]
        }
        
        private var resetViewsItems: [Item] {
            return [(NSLocalizedString("common_center_view").capitalizedString, false, nil),
                (NSLocalizedString("common_top_panel").capitalizedString, false, nil),
                (NSLocalizedString("common_left_panel").capitalizedString, false, nil),
                (NSLocalizedString("common_right_panel").capitalizedString, false, nil),
                (NSLocalizedString("common_bottom_panel").capitalizedString, false, nil)]
        }
        
        private var statusBarItems: [Item] {
            return [(NSLocalizedString("panel_view_section_status_bar_abruptly").capitalizedString, false, nil),
                    (NSLocalizedString("panel_view_section_status_bar_smoothly").capitalizedString, false, nil)]
        }
        
        private var title: String {
            let title: String
            
            switch self {
            case .PanelWidth:
                title = NSLocalizedString("panel_view_section_panel_width_title")
            case .Animation:
                title = NSLocalizedString("panel_view_section_animation_title")
            case .StatusBar:
                title = NSLocalizedString("panel_view_section_status_bar_title")
            case .OpeningGestures:
                title = NSLocalizedString("panel_view_section_opening_gestures_title")
            case .ClosingGestures:
                title = NSLocalizedString("panel_view_section_closing_gestures_title")
            case .CenterViewInteraction:
                title = NSLocalizedString("panel_view_section_center_view_interaction_title")
            case .Actions:
                title = NSLocalizedString("panel_view_section_actions_title")
            case .ResetViews:
                title = NSLocalizedString("panel_view_section_reset_views_title")
            }
            
            return title.uppercaseString
        }
    }
    
    // MARK: View Color
    
    private let backgroundViewColor = UIColor(red: (42 / 255), green: (42 / 255), blue: (42 / 255), alpha: (255 / 255))
    private let tableViewCellTextColor = UIColor(red: (168 / 255), green: (168 / 255), blue: (168 / 255), alpha: (255 / 255))
    private let tableViewSectionHeaderBackgroundColor = UIColor(red: (57 / 255), green: (57 / 255), blue: (57 / 255), alpha: (255 / 255))
    private let tableViewSectionHeaderTextColor = UIColor(red: (151 / 255), green: (151 / 255), blue: (151 / 255), alpha: (255 / 255))
    private let tableViewSeparatorColor = UIColor(red: (19 / 255), green: (19 / 255), blue: (19 / 255), alpha: (255 / 255))
    
    // MARK: Properties
    
    private var availableSections: [Section] = []
    private let basicTableViewCellId: String = "BasicTableViewCellId"
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.createView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.updateTableViewData()
    }
    
    // MARK: Create View
    
    private func createView() {
        self.createTableView()
    }
    
    private func createTableView() {
        if self.nibName == nil {
            self.tableView = UITableView(frame: CGRectZero, style: .Plain)
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.basicTableViewCellId)
            self.tableView.sectionHeaderHeight = 0
            self.tableView.sectionFooterHeight = 0
            
            self.view.addSubview(self.tableView)
            
            let views: [String: AnyObject] = ["topLayoutGuide": self.topLayoutGuide, "bottomLayoutGuide": self.bottomLayoutGuide, "tableView": self.tableView]
            
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][tableView][bottomLayoutGuide]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        }
    }
    
    // MARK: Setup View
    
    private func setupView() {
        self.view.backgroundColor = self.backgroundViewColor
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.tableView.separatorColor = self.tableViewSeparatorColor
    }
    
    // MARK: Update Table View
    
    private func updateTableView() {
        self.updateTableViewData()
        self.tableView.reloadData()
    }
    
    private func updateTableViewData() {
        self.availableSections = [.PanelWidth, .Animation, .StatusBar, .OpeningGestures, .ClosingGestures, .CenterViewInteraction, .Actions, .ResetViews]
    }
    
    private func fillCell(cell: UITableViewCell, withItem item: Item) {
        cell.textLabel?.text = item.title
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = self.tableViewCellTextColor
        cell.accessoryType = item.checkmarked ? .Checkmark : .None
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
    }
}

extension PanelViewController: UITableViewDataSource {
    
    // MARK: UITableViewDataSource Protocol
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.availableSections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.availableSections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(self.basicTableViewCellId, forIndexPath: indexPath)
        
        self.fillCell(cell, withItem: item)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableSections[section].numberOfItems
    }
}

extension PanelViewController: UITableViewDelegate {
    
    // MARK: UITableViewDelegate Protocol
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.availableSections[indexPath.section].items[indexPath.row]
        
        item.tappedClosure?()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22.5
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.text = self.availableSections[section].title
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = self.tableViewSectionHeaderTextColor
        
        let headerView = UIView()
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = self.tableViewSectionHeaderBackgroundColor
        
        let views = ["titleLabel": titleLabel]
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        headerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        return headerView
    }
}

