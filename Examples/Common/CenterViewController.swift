//
//  CenterViewController.swift
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

class CenterViewController: UIViewController {
    
    // MARK: Type Alias
    
    private typealias Item = (title: String, tappedClosure: ItemTappedClosure?)
    private typealias ItemTappedClosure = (Void) -> Void
    
    // MARK: Sections & Items
    
    private enum Section {
        case OpenClose(CenterViewController)
        case ResetViews
        
        private var items: [Item] {
            switch self {
            case .OpenClose(let centerViewController):
                return self.openCloseItems(centerViewController)
            case .ResetViews:
                return self.resetViewsItems
            }
        }
        
        private func openCloseItems(centerViewController: CenterViewController) -> [Item] {
            let slidingPanelController = centerViewController.slidingPanelController
            
            let topPanelActionText: String
            let topPanelText: String
            let topPanelClosure: ItemTappedClosure?
            let leftPanelActionText: String
            let leftPanelText: String
            let leftPanelClosure: ItemTappedClosure?
            let rightPanelActionText: String
            let rightPanelText: String
            let rightPanelClosure: ItemTappedClosure?
            let bottomPanelActionText: String
            let bottomPanelText: String
            let bottomPanelClosure: ItemTappedClosure?
            
            let updateTableView: SlidingPanelController.ActionCompletion = { centerViewController.updateTableView() }
            
            topPanelActionText = (slidingPanelController?.panelSideDisplayed == .Top) ? NSLocalizedString("common_close") : NSLocalizedString("common_open")
            leftPanelActionText = (slidingPanelController?.panelSideDisplayed == .Left) ? NSLocalizedString("common_close") : NSLocalizedString("common_open")
            rightPanelActionText = (slidingPanelController?.panelSideDisplayed == .Right) ? NSLocalizedString("common_close") : NSLocalizedString("common_open")
            bottomPanelActionText = (slidingPanelController?.panelSideDisplayed == .Bottom) ? NSLocalizedString("common_close") : NSLocalizedString("common_open")
            
            topPanelText = NSString(format: NSLocalizedString("common_panel_action"), topPanelActionText, NSLocalizedString("common_top_panel")).capitalizedString as String
            leftPanelText = NSString(format: NSLocalizedString("common_panel_action"), leftPanelActionText, NSLocalizedString("common_left_panel")).capitalizedString as String
            rightPanelText = NSString(format: NSLocalizedString("common_panel_action"), rightPanelActionText, NSLocalizedString("common_right_panel")).capitalizedString as String
            bottomPanelText = NSString(format: NSLocalizedString("common_panel_action"), bottomPanelActionText, NSLocalizedString("common_bottom_panel")).capitalizedString as String
            
            topPanelClosure = { (slidingPanelController?.panelSideDisplayed == .Top) ? slidingPanelController?.closePanel(updateTableView) : slidingPanelController?.openTopPanel(updateTableView) }
            leftPanelClosure = { (slidingPanelController?.panelSideDisplayed == .Left) ? slidingPanelController?.closePanel(updateTableView) : slidingPanelController?.openLeftPanel(updateTableView) }
            rightPanelClosure = { (slidingPanelController?.panelSideDisplayed == .Right) ? slidingPanelController?.closePanel(updateTableView) : slidingPanelController?.openRightPanel(updateTableView) }
            bottomPanelClosure = { (slidingPanelController?.panelSideDisplayed == .Bottom) ? slidingPanelController?.closePanel(updateTableView) : slidingPanelController?.openBottomPanel(updateTableView) }

            return [(topPanelText, topPanelClosure),
                    (leftPanelText, leftPanelClosure),
                    (rightPanelText, rightPanelClosure),
                    (bottomPanelText, bottomPanelClosure)]
        }
        
        private var numberOfItems: Int {
            return self.items.count
        }
        
        private var resetViewsItems: [Item] {
            return [(NSLocalizedString("common_center_view").capitalizedString, nil),
                    (NSLocalizedString("common_top_panel").capitalizedString, nil),
                    (NSLocalizedString("common_left_panel").capitalizedString, nil),
                    (NSLocalizedString("common_right_panel").capitalizedString, nil),
                    (NSLocalizedString("common_bottom_panel").capitalizedString, nil)]
        }
        
        private var title: String {
            switch self {
            case .OpenClose:
                return NSLocalizedString("center_view_section_open_close_title")
            case .ResetViews:
                return NSLocalizedString("center_view_section_reset_views_title")
            }
        }
    }
    
    // MARK: Properties
    
    @IBOutlet private var appInfoLabel: UILabel!
    private var availableSections: [Section] = []
    private let basicTableViewCellId: String = "BasicTableViewCellId"
    @IBOutlet private var copyrightLabel: UILabel!
    @IBOutlet private var navBarLeftMenuButtonItem: UIBarButtonItem!
    @IBOutlet private var navBarRightMenuButtonItem: UIBarButtonItem!
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
        self.createNavBar()
        self.createTableView()
    }
    
    private func createNavBar() {
        if self.nibName == nil {
            self.navBarLeftMenuButtonItem = UIBarButtonItem()
            self.navigationItem.leftBarButtonItem = self.navBarLeftMenuButtonItem
            
            self.navBarRightMenuButtonItem = UIBarButtonItem()
            self.navigationItem.rightBarButtonItem = self.navBarRightMenuButtonItem
        }
    }
    
    private func createTableView() {
        if self.nibName == nil {
            self.tableView = UITableView(frame: CGRectZero, style: .Grouped)
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.basicTableViewCellId)
            
            let footerView: UIView = UIView()
            
            self.appInfoLabel = UILabel()
            self.appInfoLabel.font = UIFont.systemFontOfSize(10)
            self.appInfoLabel.textAlignment = .Center
            
            self.copyrightLabel = UILabel()
            self.copyrightLabel.font = UIFont.systemFontOfSize(10)
            self.copyrightLabel.textAlignment = .Center
            
            footerView.addSubview(self.appInfoLabel)
            footerView.addSubview(self.copyrightLabel)
            self.view.addSubview(self.tableView)
            
            let views: [String: AnyObject] = ["tableView": self.tableView, "footerView": footerView, "appInfoLabel": self.appInfoLabel, "copyrightLabel": self.copyrightLabel]
            
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            
            self.appInfoLabel.translatesAutoresizingMaskIntoConstraints = false
            self.copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
            footerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[appInfoLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            footerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[copyrightLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            footerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[appInfoLabel(12)][copyrightLabel(12)]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            footerView.frame.size.height = footerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            
            self.tableView.tableFooterView = footerView
        }
    }
    
    // MARK: Setup View
    
    private func setupView() {
        self.setupNavBar()
        self.setupTableView()
    }
    
    private func setupNavBar() {
        self.title = NSLocalizedString("common_sliding_panel")
        
        self.navBarLeftMenuButtonItem.image = GraphicalResources.imageOfMenuIcon
        self.navBarLeftMenuButtonItem.target = self
        self.navBarLeftMenuButtonItem.action = #selector(CenterViewController.leftButtonTapped)
        
        self.navBarRightMenuButtonItem.image = GraphicalResources.imageOfMenuIcon
        self.navBarRightMenuButtonItem.target = self
        self.navBarRightMenuButtonItem.action = #selector(CenterViewController.rightButtonTapped)
    }
    
    private func setupTableView() {
        self.appInfoLabel.text = NSLocalizedString(AppDelegate.appInfoKey)
        self.copyrightLabel.text = NSLocalizedString("copyright")
    }
    
    // MARK: Update Table View
    
    internal func updateTableView() {
        self.updateTableViewData()
        self.tableView.reloadData()
    }
    
    private func updateTableViewData() {
        self.availableSections = [.OpenClose(self), .ResetViews]
    }
    
    private func fillCell(cell: UITableViewCell, withItem item: Item) {
        cell.textLabel?.text = item.title
    }
    
    // MARK: Actions
    
    private dynamic func leftButtonTapped() {
        let updateTableView: SlidingPanelController.ActionCompletion = { self.updateTableView() }
        
        if slidingPanelController?.panelSideDisplayed == .Left {
            self.slidingPanelController?.closePanel(updateTableView)
        } else {
            self.slidingPanelController?.openLeftPanel(updateTableView)
        }
    }
    
    private dynamic func rightButtonTapped() {
        let updateTableView: SlidingPanelController.ActionCompletion = { self.updateTableView() }
        
        if slidingPanelController?.panelSideDisplayed == .Right {
            self.slidingPanelController?.closePanel(updateTableView)
        } else {
            self.slidingPanelController?.openRightPanel(updateTableView)
        }
    }
}

extension CenterViewController: UITableViewDataSource {
    
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.availableSections[section].title
    }
}

extension CenterViewController: UITableViewDelegate {
    
    // MARK: UITableViewDelegate Protocol
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.availableSections[indexPath.section].items[indexPath.row]
        
        item.tappedClosure?()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
