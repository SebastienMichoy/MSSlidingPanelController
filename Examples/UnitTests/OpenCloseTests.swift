//
//  OpenCloseTests.swift
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

import SlidingPanelExamples_Programmatically
import XCTest

class OpenTests: XCTestCase {
    
    // MARK: Tests Setup
    
    override func setUp() {
        super.setUp()
        
        let application = UIApplication.sharedApplication()
        
        guard let window = application.keyWindow else {
            XCTFail("No window found.")
            return
        }
        
        let centerViewController = UIViewController()
        let leftViewController = UIViewController()
        let rightViewController = UIViewController()
        let topViewController = UIViewController()
        let bottomViewController = UIViewController()
        
        self.slidingPanelController = SlidingPanelController(centerViewController: centerViewController, leftViewController: leftViewController, rightViewController: rightViewController, topViewController: topViewController, bottomViewController: bottomViewController)
        
        window.rootViewController = self.slidingPanelController
        
        // Forces the view life cycle
        // The sliding panel controller have to be displayed before the test begins
        let _ = self.slidingPanelController.view
        self.slidingPanelController.viewWillAppear(false)
        self.slidingPanelController.viewDidAppear(false)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Properties
    
    var slidingPanelController: SlidingPanelController!
    
    // MARK: Tests
    
    func testOpenCloseLeft() {
        let expectation = expectationWithDescription("Open the left panel.")
        
        XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
        XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
        
        self.slidingPanelController.openLeftPanel {
            XCTAssertEqual(self.slidingPanelController.panelSideDisplayed, .Left, "The panel side displayed is not the left one.")
            XCTAssertEqual(self.slidingPanelController.percentageVisibleForPanelDisplayed, 1, "The panel side displayed is not fully opened.")
            
            self.slidingPanelController.closePanel {
                XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
                XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout((self.slidingPanelController.animationDuration(forSide: .Left) * 2) + 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testOpenCloseRight() {
        let expectation = expectationWithDescription("Open the right panel.")
        
        XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
        XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
        
        self.slidingPanelController.openRightPanel {
            XCTAssertEqual(self.slidingPanelController.panelSideDisplayed, .Right, "The panel side displayed is not the right one.")
            XCTAssertEqual(self.slidingPanelController.percentageVisibleForPanelDisplayed, 1, "The panel side displayed is not fully opened.")
            
            self.slidingPanelController.closePanel {
                XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
                XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout((self.slidingPanelController.animationDuration(forSide: .Right) * 2) + 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testOpenCloseTop() {
        let expectation = expectationWithDescription("Open the top panel.")
        
        XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
        XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
        
        self.slidingPanelController.openTopPanel {
            XCTAssertEqual(self.slidingPanelController.panelSideDisplayed, .Top, "The panel side displayed is not the top one.")
            XCTAssertEqual(self.slidingPanelController.percentageVisibleForPanelDisplayed, 1, "The panel side displayed is not fully opened.")
            
            self.slidingPanelController.closePanel {
                XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
                XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout((self.slidingPanelController.animationDuration(forSide: .Top) * 2) + 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testOpenCloseBottom() {
        let expectation = expectationWithDescription("Open the bottom panel.")
        
        XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
        XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
        
        self.slidingPanelController.openBottomPanel {
            XCTAssertEqual(self.slidingPanelController.panelSideDisplayed, .Bottom, "The panel side displayed is not the bottom one.")
            XCTAssertEqual(self.slidingPanelController.percentageVisibleForPanelDisplayed, 1, "The panel side displayed is not fully opened.")
            
            self.slidingPanelController.closePanel {
                XCTAssertNil(self.slidingPanelController.panelSideDisplayed, "The panel side displayed is not nil.")
                XCTAssertNil(self.slidingPanelController.percentageVisibleForPanelDisplayed, "The panel side displayed is not fully closed.")
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout((self.slidingPanelController.animationDuration(forSide: .Bottom) * 2) + 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
