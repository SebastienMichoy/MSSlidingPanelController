//
//  CenterSlidingAnimationTests.swift
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

@testable import SlidingPanelExamples_Programmatically
import XCTest

final class CenterSlidingAnimationTests: XCTestCase {
    
    // MARK: Tests Setup
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Helper
    
    private func checkInitialPanelFrame(withSlidingPanelController slidingPanelController: SlidingPanelController, animation: CenterSlidingAnimation, andSide side: SlidingPanelController.Side) {
        let expectedFrame: CGRect
        let initialFrame: CGRect
        let sideString: String
        
        let slidingPanelControllerWidth = slidingPanelController.view.bounds.width
        let slidingPanelControllerHeight = slidingPanelController.view.bounds.height
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        switch side {
        case .Left:
            width = slidingPanelController.leftPanelWidth
            height = slidingPanelControllerHeight
            sideString = "left"
        case .Right:
            x = slidingPanelControllerWidth - slidingPanelController.rightPanelWidth
            width = slidingPanelController.rightPanelWidth
            height = slidingPanelControllerHeight
            sideString = "right"
        case .Top:
            width = slidingPanelControllerWidth
            height = slidingPanelController.topPanelHeight
            sideString = "top"
        case .Bottom:
            y = slidingPanelControllerHeight - slidingPanelController.bottomPanelHeight
            width = slidingPanelControllerWidth
            height = slidingPanelController.bottomPanelHeight
            sideString = "bottom"
        }
        
        expectedFrame = CGRect(x: x, y: y, width: width, height: height)
        initialFrame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: side)
        
        XCTAssertEqual(initialFrame, expectedFrame, "The \(sideString) panel initial frame doesn't match.")
    }
    
    private func checkPositionInViewHierarchy(withSlidingPanelController slidingPanelController: SlidingPanelController, animation: CenterSlidingAnimation, andSide side: SlidingPanelController.Side) {
        let position = animation.panelPositionInViewHierarchy(forSlidingPanelController: slidingPanelController, andSide: side)
        let expectedPosition = SlidingPanelController.PanelPositionViewHierarchy.BelowCenterView
        let sideString: String
        
        switch side {
        case .Left:     sideString = "left"
        case .Right:    sideString = "right"
        case .Top:      sideString = "top"
        case .Bottom:   sideString = "bottom"
        }
        
        XCTAssertEqual(position, expectedPosition, "The \(sideString) panel view hierarchy doesn't match.")
    }
    
    private func checkAnimation(withSlidingPanelController slidingPanelController: SlidingPanelController, animation: CenterSlidingAnimation, side: SlidingPanelController.Side, andVisiblePercentage percentage: CGFloat) {
        let leftExpectedPanelFrame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Left)
        let rightExpectedPanelFrame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Right)
        let topExpectedPanelFrame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Top)
        let bottomExpectedPanelFrame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Bottom)
        
        let expectedFrame: CGRect
        let frame: CGRect
        
        let slidingPanelControllerWidth = slidingPanelController.view.bounds.width
        let slidingPanelControllerHeight = slidingPanelController.view.bounds.height
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        
        switch side {
        case .Left: x = slidingPanelController.leftPanelWidth * percentage
        case .Right: x = -slidingPanelController.rightPanelWidth * percentage
        case .Top: y = slidingPanelController.topPanelHeight * percentage
        case .Bottom: y = -slidingPanelController.bottomPanelHeight * percentage
        }
        
        animation.animate(SlidingPanelController: slidingPanelController, withSide: side, andVisiblePercentage: percentage)

        expectedFrame = CGRect(x: x, y: y, width: slidingPanelControllerWidth, height: slidingPanelControllerHeight)
        frame = slidingPanelController.centerView.frame
        
        XCTAssertEqual(frame, expectedFrame, "The center view frame doesn't match.")
        if let leftPanelFrame = slidingPanelController.leftView?.frame { XCTAssertEqual(leftPanelFrame, leftExpectedPanelFrame, "The left panel frame doesn't match.") }
        if let rightPanelFrame = slidingPanelController.rightView?.frame { XCTAssertEqual(rightPanelFrame, rightExpectedPanelFrame, "The right panel frame doesn't match.") }
        if let topPanelFrame = slidingPanelController.topView?.frame { XCTAssertEqual(topPanelFrame, topExpectedPanelFrame, "The top panel frame doesn't match.") }
        if let bottomPanelFrame = slidingPanelController.bottomView?.frame { XCTAssertEqual(bottomPanelFrame, bottomExpectedPanelFrame, "The bottom panel frame doesn't match.") }
    }
    
    // MARK: Tests
    
    func testInitialPosition() {
        let animation = CenterSlidingAnimation()
        let centerViewController = UIViewController()
        
        let slidingPanelController = SlidingPanelController(centerViewController: centerViewController)
        slidingPanelController.leftPanelWidth = 50
        slidingPanelController.rightPanelWidth = 50
        slidingPanelController.topPanelHeight = 50
        slidingPanelController.bottomPanelHeight = 50
        
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Left)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Right)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Top)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Bottom)
        
        slidingPanelController.leftPanelWidth = 200
        slidingPanelController.rightPanelWidth = 200
        slidingPanelController.topPanelHeight = 200
        slidingPanelController.bottomPanelHeight = 200
        
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Left)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Right)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Top)
        self.checkInitialPanelFrame(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Bottom)
    }
    
    func testPositionInViewHierarchy() {
        let animation = CenterSlidingAnimation()
        let centerViewController = UIViewController()
        let slidingPanelController = SlidingPanelController(centerViewController: centerViewController)
        
        self.checkPositionInViewHierarchy(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Left)
        self.checkPositionInViewHierarchy(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Right)
        self.checkPositionInViewHierarchy(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Top)
        self.checkPositionInViewHierarchy(withSlidingPanelController: slidingPanelController, animation: animation, andSide: .Bottom)
    }
    
    func testAnimation() {
        let animation = CenterSlidingAnimation()
        
        let centerViewController = UIViewController()
        let leftViewController = UIViewController()
        let rightViewController = UIViewController()
        let topViewController = UIViewController()
        let bottomViewController = UIViewController()
        
        let slidingPanelController = SlidingPanelController(centerViewController: centerViewController)
        slidingPanelController.leftViewController = leftViewController
        slidingPanelController.rightViewController = rightViewController
        slidingPanelController.topViewController = topViewController
        slidingPanelController.bottomViewController = bottomViewController
        
        leftViewController.view.frame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Left)
        rightViewController.view.frame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Right)
        topViewController.view.frame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Top)
        bottomViewController.view.frame = animation.panelInitialFrame(forSlidingPanelController: slidingPanelController, andSide: .Bottom)
        
        var percentageVisible = CGFloat(0)
        
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Left, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Right, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Top, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Bottom, andVisiblePercentage: percentageVisible)
        
        percentageVisible = 25
        
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Left, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Right, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Top, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Bottom, andVisiblePercentage: percentageVisible)
        
        percentageVisible = 50
        
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Left, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Right, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Top, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Bottom, andVisiblePercentage: percentageVisible)
        
        percentageVisible = 75
        
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Left, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Right, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Top, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Bottom, andVisiblePercentage: percentageVisible)
        
        percentageVisible = 100
        
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Left, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Right, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Top, andVisiblePercentage: percentageVisible)
        self.checkAnimation(withSlidingPanelController: slidingPanelController, animation: animation, side: .Bottom, andVisiblePercentage: percentageVisible)
    }
}