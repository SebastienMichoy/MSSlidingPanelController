//
//  StoryboardInitializationTests.swift
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

import class SlidingPanelExamples_Programmatically.SlidingPanelController
import XCTest

class StoryboardInitializationTests: XCTestCase {
    
    // MARK: Tests Setup
    
    override func setUp() {
        super.setUp()
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        self.slidingPanelController = storyboard.instantiateInitialViewController() as! SlidingPanelController
        
        // Forces the view life cycle
        let _ = self.slidingPanelController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Properties
    
    var slidingPanelController: SlidingPanelController!
    
    // MARK: Tests
    
    func testControllersSet() {
        XCTAssertNotNil(self.slidingPanelController.leftViewController, "The left view controller is nil.")
        XCTAssertNotNil(self.slidingPanelController.rightViewController, "The right view controller is nil.")
        XCTAssertNotNil(self.slidingPanelController.topViewController, "The top view controller is nil.")
        XCTAssertNotNil(self.slidingPanelController.bottomViewController, "The bottom view controller is nil.")
    }
    
    func testControllersWithSlidingPanelControllerAsParent() {
        XCTAssertEqual(self.slidingPanelController.centerViewController.slidingPanelController, slidingPanelController, "The center view controller don't have the sliding panel controller as parent.")
        XCTAssertEqual(self.slidingPanelController.leftViewController?.slidingPanelController, slidingPanelController, "The left view controller don't have the sliding panel controller as parent.")
        XCTAssertEqual(self.slidingPanelController.rightViewController?.slidingPanelController, slidingPanelController, "The right view controller don't have the sliding panel controller as parent.")
        XCTAssertEqual(self.slidingPanelController.topViewController?.slidingPanelController, slidingPanelController, "The top view controller don't have the sliding panel controller as parent.")
        XCTAssertEqual(self.slidingPanelController.bottomViewController?.slidingPanelController, slidingPanelController, "The bottom view controller don't have the sliding panel controller as parent.")
    }
    
    func testControllersWithViewInHierarchy() {
        XCTAssertNotNil(self.slidingPanelController.centerView?.superview, "The center view is not in the view hierarchy.")
        XCTAssertNil(self.slidingPanelController.leftView?.superview, "The left view is in the view hierarchy.")
        XCTAssertNil(self.slidingPanelController.rightView?.superview, "The right view is in the view hierarchy.")
        XCTAssertNil(self.slidingPanelController.topView?.superview, "The top view is in the view hierarchy.")
        XCTAssertNil(self.slidingPanelController.bottomView?.superview, "The bottom view is in the view hierarchy.")
    }
}
