//
//  SlidingPanelController.swift
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

/**
The `SlidingPanelController` is a class that manages panels.
It is possible to add until 4 panels (top, left, right and bottom) and to display and hide them with several animations.
*/
public final class SlidingPanelController: UIViewController {
    
    // MARK: Type Alias
    
    public typealias ActionCompletion = (Void) -> Void
    private typealias ViewInformation = (frame: CGRect, panelPositionViewHierarchy: PanelPositionViewHierarchy)
    
    // MARK: Segues
    
    /**
    Corresponds to storyboard's segues of `SlidingPanelController`.
    The `rawValue` is the string identifier used in the storyboard.
    
    - Center: The center view controller segue identifier.
    - Left:   The left view controller segue identifier.
    - Right:  The right view controller segue identifier.
    - Top:    The top view controller segue identifier.
    - Bottom: The bottom view controller segue identifier.
    */
    private enum Segue: String {
        case Bottom = "SPCSegueBottomVCId"
        case Center = "SPCSegueCenterVCId"
        case Left = "SPCSegueLeftVCId"
        case Right = "SPCSegueRightVCId"
        case Top = "SPCSegueTopVCId"
    }
    
    // MARK: Sides
    
    /**
    Represents a panel side.
    
    - Bottom: The bottom side.
    - Left:   The left side.
    - Right:  The right side.
    - Top:    The top side.
    */
    public enum Side {
        case Bottom
        case Left
        case Right
        case Top
        
        private init?(side: SidePercentage?) {
            guard let side = side else { return nil }
            
            switch side {
            case .Bottom(_): self = .Bottom
            case .Left(_): self = .Left
            case .Right(_): self = .Right
            case .Top(_): self = .Top
            }
        }
    }
    
    /**
    Represents a panel side.
    This enum is only used internally.
     
    - Bottom: The bottom side. Its associated value corresponds to its percentage visible.
    - Left:   The left side. Its associated value corresponds to its percentage visible.
    - Right:  The right side. Its associated value corresponds to its percentage visible.
    - Top:    The top side. Its associated value corresponds to its percentage visible.
    */
    private enum SidePercentage {
        case Bottom(CGFloat)
        case Left(CGFloat)
        case Right(CGFloat)
        case Top(CGFloat)
        
        private init(side: Side, andPercentageVisible percentageVisible: CGFloat) {
            switch side {
            case .Bottom: self = .Bottom(percentageVisible)
            case .Left: self = .Left(percentageVisible)
            case .Right: self = .Right(percentageVisible)
            case .Top: self = .Top(percentageVisible)
            }
        }
        
        private var percentage: CGFloat {
            switch self {
            case .Bottom(let percentage): return percentage
            case .Left(let percentage): return percentage
            case .Right(let percentage): return percentage
            case .Top(let percentage): return percentage
            }
        }
    }
    
    // MARK: Animations
    
    /**
    Represents a animation type.
    
    - CenterSliding: The center view slides to reveal the panel hides under it.
    - PanelSliding:  The panel view slides on the center view located under it.
    */
    public enum AnimationType {
        case CenterSliding
        case PanelSliding
        
        private var slidingPanelAnimation: SlidingPanelAnimatable {
            switch self {
            case .CenterSliding: return CenterSlidingAnimation()
            case .PanelSliding: return PanelSlidingAnimation()
            }
        }
    }
    
    // MARK: Panel Position in the View Hierarchy
    
    /**
    Represents the position of the panel into the view hierarchy compared to the center view.
    
    - AboveCenterView: The panel have to be placed above the center view.
    - BelowCenterView: The panel have to be placed below the center view.
    */
    public enum PanelPositionViewHierarchy {
        case AboveCenterView
        case BelowCenterView
    }
    
    // MARK: Designated Initializers
    
    /**
    Returns an object initialized from data in a given unarchiver.
    
    - parameter aDecoder: An unarchiver object.
    
    - returns: `self`, initialized using the data in decoder.
    */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the appropriate controllers.
     
    - parameter centerViewController: The center view controller.
    - parameter leftViewController:   The left view controller.
    - parameter rightViewController:  The right view controller.
    - parameter topViewController:    The top view controller.
    - parameter bottomViewController: The bottom view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    public init(centerViewController: UIViewController, leftViewController: UIViewController?, rightViewController: UIViewController?, topViewController: UIViewController?, bottomViewController: UIViewController?) {
        
        self._centerViewController = centerViewController
        self.leftViewController = leftViewController
        self.rightViewController = rightViewController
        self.topViewController = topViewController
        self.bottomViewController = bottomViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Convenience Initializers
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller.
    
    - parameter centerViewController: The center view controller.
    
    - returns: `self`, initialized with the controller.
    */
    convenience public init(centerViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: nil, rightViewController: nil, topViewController: nil, bottomViewController: nil)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller and the left view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter leftViewController:   The left view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, leftViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: leftViewController, rightViewController: nil, topViewController: nil, bottomViewController: nil)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller and the right view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter rightViewController:  The right view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, rightViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: nil, rightViewController: rightViewController, topViewController: nil, bottomViewController: nil)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller and the top view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter topViewController:    The top view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, topViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: nil, rightViewController: nil, topViewController: topViewController, bottomViewController: nil)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller and the bottom view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter bottomViewController: The bottom view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, bottomViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: nil, rightViewController: nil, topViewController: nil, bottomViewController: bottomViewController)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller, the left view controller, and the right view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter leftViewController:   The left view controller.
    - parameter rightViewController:  The right view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: leftViewController, rightViewController: rightViewController, topViewController: nil, bottomViewController: nil)
    }
    
    /**
    Returns an `SlidingPanelController` initialized with the center view controller, the top view controller, and the bottom view controller.
     
    - parameter centerViewController: The center view controller.
    - parameter topViewController:    The top view controller.
    - parameter bottomViewController: The bottom view controller.
     
    - returns: `self`, initialized with the controllers.
    */
    convenience public init(centerViewController: UIViewController, topViewController: UIViewController, bottomViewController: UIViewController) {
        self.init(centerViewController: centerViewController, leftViewController: nil, rightViewController: nil, topViewController: topViewController, bottomViewController: bottomViewController)
    }
    
    // MARK: Controller Life Cycle
    
    /**
    Called after the controller's view is loaded into memory.
    */
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if self._initializedViaStoryboard {
            self.checkStoryboardInitialization()
        } else {
            self.addEveryViewControllersAsSlidingChildViewController()
        }
        
        let viewInformation =  ViewInformation(frame: self.view.bounds, panelPositionViewHierarchy: .AboveCenterView)
        self.addSlidingChildViewController(centerViewController, withViewInformation: viewInformation)
    }
    
    /**
    Notifies the view controller that its view was added to a view hierarchy.
    
    - parameter animated: If `YES`, the view was added to the window using an animation.
    */
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setUpDisplayLink()
    }
    
    // MARK: Controller Information
    
    /**
    Indicates if the initialization has been done via storyboard.
    */
    private var _initializedViaStoryboard: Bool {
        return self.nibName != nil
    }
    
    /**
    The panel side displayed. Return `nil` if no panel is displayed.
    This property must be used only for internal purpose.
    */
    private var _panelSideDisplayed: SidePercentage?
    
    /**
    The panel side displayed. Return `nil` if no panel is displayed.
    */
    public var panelSideDisplayed: Side? {
        return Side(side: self._panelSideDisplayed)
    }
    
    public var percentageVisibleForPanelDisplayed: CGFloat? {
        get {
            return self._panelSideDisplayed?.percentage
        }
        
        set {
            guard let panelSideDisplayed = self._panelSideDisplayed else { return }
            let newValue = newValue ?? 0
            
            switch panelSideDisplayed {
            case .Left: self._panelSideDisplayed = .Left(newValue)
            case .Right: self._panelSideDisplayed = .Right(newValue)
            case .Top: self._panelSideDisplayed = .Top(newValue)
            case .Bottom: self._panelSideDisplayed = .Bottom(newValue)
            }
        }
    }
    
    // MARK: Center View Controller
    
    /**
    The center container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _centerContainerView: UIView!
    
    /**
    The center view controller's view.
    */
    public var centerView: UIView! {
        return self.centerViewController.view
    }
    
    /**
    The center view controller used internally.
    It is optional to manage the initialization via Storyboard.
    */
    private var _centerViewController: UIViewController! {
        willSet {
            if let centerViewController = self._centerViewController {
                self._previousCenterViewFrame = centerView.frame
                self.removeSlidingChildViewController(centerViewController, withView: centerViewController.view)
            }
        }
        
        didSet {
            if let centerViewController = self._centerViewController {
                let viewInformation = ViewInformation(frame: centerView.frame, panelPositionViewHierarchy: .AboveCenterView)
                self.addSlidingChildViewController(centerViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    /**
    The center view controller.
    */
    public var centerViewController: UIViewController {
        get {
            return self._centerViewController
        }
        
        set {
            self._centerViewController = newValue
        }
    }
    
    /**
    Contains the previous center view frame. Is `nil` is there were no previous center view.
    */
    private var _previousCenterViewFrame: CGRect?
    
    // MARK: Left View Controller
    
    /**
    The left animation instance.
    This properties must not be set directly. Instead, set `leftAnimationType`.
    */
    private var _leftAnimation: SlidingPanelAnimatable = AnimationType.CenterSliding.slidingPanelAnimation
    
    /**
    The left animation duration, in seconds.
    It's default value is `1`.
    */
    private var leftAnimationDuration: NSTimeInterval = 1
    
    /**
    The type of animation used for the left panel interactions.
    It's default value is `.CenterSliding`.
    */
    public var leftAnimationType: AnimationType = .CenterSliding {
        didSet {
            self._leftAnimation = self.leftAnimationType.slidingPanelAnimation
        }
    }
    
    /**
    The left container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _leftContainerView: UIView!
    
    /**
    The left panel width.
    It's default value is 200.
    */
    public var leftPanelWidth: CGFloat = 200
    
    /**
    The left view controller's view.
    */
    public var leftView: UIView? {
        return self.leftViewController?.view
    }
    
    /**
    The view controller used as left panel.
    */
    public var leftViewController: UIViewController? {
        willSet {
            var viewInformation: ViewInformation?
            
            if let leftViewController = self.leftViewController {
                if let leftView = self.leftView, index = self.view.subviews.indexOf(leftView), centerViewIndex = self.view.subviews.indexOf(self.centerView) {
                    let panelPosition: PanelPositionViewHierarchy = (index > centerViewIndex) ? .AboveCenterView : .BelowCenterView
                    viewInformation = ViewInformation(frame: leftView.frame, panelPositionViewHierarchy: panelPosition)
                }
                
                self.removeSlidingChildViewController(leftViewController, withView: self.leftView)
            }
            
            if let newLeftViewController = newValue {
                self.addSlidingChildViewController(newLeftViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    // MARK: Right View Controller
    
    /**
    The right animation instance.
    This properties must not be set directly. Instead, set `rightAnimationType`.
    */
    private var _rightAnimation: SlidingPanelAnimatable = AnimationType.CenterSliding.slidingPanelAnimation
    
    /**
    The right animation duration, in seconds.
    It's default value is `1`.
    */
    private var rightAnimationDuration: NSTimeInterval = 1
    
    /**
    The type of animation used for the right panel interactions.
    It's default value is `.CenterSliding`.
    */
    public var rightAnimationType: AnimationType = .CenterSliding {
        didSet {
            self._rightAnimation = self.rightAnimationType.slidingPanelAnimation
        }
    }
    
    /**
    The right container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _rightContainerView: UIView!
    
    /**
    The right panel width.
    It's default value is 200.
    */
    public var rightPanelWidth: CGFloat = 200
    
    /**
    The right view controller's view.
    */
    public var rightView: UIView? {
        return self.rightViewController?.view
    }
    
    /**
    The view controller used as right panel.
    */
    public var rightViewController: UIViewController? {
        willSet {
            var viewInformation: ViewInformation?
            
            if let rightViewController = self.rightViewController {
                if let rightView = self.rightView, index = self.view.subviews.indexOf(rightView), centerViewIndex = self.view.subviews.indexOf(self.centerView) {
                    let panelPosition: PanelPositionViewHierarchy = (index > centerViewIndex) ? .AboveCenterView : .BelowCenterView
                    viewInformation = ViewInformation(frame: rightView.frame, panelPositionViewHierarchy: panelPosition)
                }
                
                self.removeSlidingChildViewController(rightViewController, withView: self.rightView)
            }
            
            if let newRightViewController = newValue {
                self.addSlidingChildViewController(newRightViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    // MARK: Top View Controller
    
    /**
    The top animation instance.
    This properties must not be set directly. Instead, set `topAnimationType`.
    */
    private var _topAnimation: SlidingPanelAnimatable = AnimationType.PanelSliding.slidingPanelAnimation
    
    /**
    The top animation duration, in seconds.
    It's default value is `1`.
    */
    private var topAnimationDuration: NSTimeInterval = 1
    
    /**
    The type of animation used for the top panel interactions.
    It's default value is `.PanelSliding`.
    */
    public var topAnimationType: AnimationType = .PanelSliding {
        didSet {
            self._topAnimation = self.topAnimationType.slidingPanelAnimation
        }
    }
    
    /**
    The top container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _topContainerView: UIView!
    
    /**
    The top panel height.
    It's default value is 360.
    */
    public var topPanelHeight: CGFloat = 360
    
    /**
    The top view controller's view.
    */
    public var topView: UIView? {
        return self.topViewController?.view
    }
    
    /**
    The view controller used as top panel.
    */
    public var topViewController: UIViewController? {
        willSet {
            var viewInformation: ViewInformation?
            
            if let topViewController = self.topViewController {
                if let topView = self.topView, index = self.view.subviews.indexOf(topView), centerViewIndex = self.view.subviews.indexOf(self.centerView) {
                    let panelPosition: PanelPositionViewHierarchy = (index > centerViewIndex) ? .AboveCenterView : .BelowCenterView
                    viewInformation = ViewInformation(frame: topView.frame, panelPositionViewHierarchy: panelPosition)
                }
                
                self.removeSlidingChildViewController(topViewController, withView: self.topView)
            }
            
            if let newTopViewController = newValue {
                self.addSlidingChildViewController(newTopViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    // MARK: Bottom View Controller
    
    /**
    The bottom animation instance.
    This properties must not be set directly. Instead, set `bottomAnimationType`.
    */
    private var _bottomAnimation: SlidingPanelAnimatable = AnimationType.PanelSliding.slidingPanelAnimation
    
    /**
    The bottom animation duration, in seconds.
    It's default value is `1`.
    */
    private var bottomAnimationDuration: NSTimeInterval = 1
    
    /**
    The type of animation used for the bottom panel interactions.
    It's default value is `.PanelSliding`.
    */
    public var bottomAnimationType: AnimationType = .PanelSliding {
        didSet {
            self._bottomAnimation = self.bottomAnimationType.slidingPanelAnimation
        }
    }
    
    /**
    The bottom container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _bottomContainerView: UIView!
    
    /**
    The bottom panel height.
    It's default value is 360.
    */
    public var bottomPanelHeight: CGFloat = 360
    
    /**
    The bottom view controller's view.
    */
    public var bottomView: UIView? {
        return self.bottomViewController?.view
    }
    
    /**
    The view controller used as bottom panel.
    */
    public var bottomViewController: UIViewController? {
        willSet {
            var viewInformation: ViewInformation?
            
            if let bottomViewController = self.bottomViewController {
                if let bottomView = self.bottomView, index = self.view.subviews.indexOf(bottomView), centerViewIndex = self.view.subviews.indexOf(self.centerView) {
                    let panelPosition: PanelPositionViewHierarchy = (index > centerViewIndex) ? .AboveCenterView : .BelowCenterView
                    viewInformation = ViewInformation(frame: bottomView.frame, panelPositionViewHierarchy: panelPosition)
                }
                
                self.removeSlidingChildViewController(bottomViewController, withView: self.bottomView)
            }
            
            if let newBottomViewController = newValue {
                self.addSlidingChildViewController(newBottomViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    // MARK: Actions
    
    /**
    Represents a panel action.
    
    - Opening: The panel is opening. Its associated value corresponds to the beginning date of the action and the completion executed when the action is done.
    - Closing: The panel is closing. Its associated value corresponds to the beginning date of the action and the completion executed when the action is done.
    */
    private enum Action {
        case Closing(NSDate?, ActionCompletion?)
        case Opening(NSDate?, ActionCompletion?)
    }
    
    /**
    Closes the displayed panel.
    
    - parameter completion: The closure to execute after the panel closes.
    */
    public func closePanel(completion: ActionCompletion? = nil) {
//        if let side = self.panelSideDisplayed, panelViewController = self.panelViewControllerForSide(side), percentageVisible = self.percentageVisibleForPanelDisplayed {
//            let localCompletion: ActionCompletion = { _ in
//                self.panelSideDisplayedInternal = nil
//                self.removeChildViewController(panelViewController)
//                completion?()
//            }
//            
//            self.currentAction = .Closing(NSDate(), localCompletion)
//            self.displayLink?.paused = false
//            
//            if percentageVisible == 1 {
//                self.animationForSide(side).slidingPanelController(self, willBeginAnimationForSide: side)
//            }
//        } else {
//            completion?()
//        }
    }
    
    /**
    The action currently executed by the controller.
    */
    private var _currentAction: Action?
    
    /**
    Opens the bottom panel.
    
    - parameter completion: The closure to execute after the panel opens.
    */
    public func openBottomPanel(completion: ActionCompletion? = nil) {
        self.openPanel(.Bottom, withCompletion: completion)
    }
    
    /**
    Opens the left panel.
     
    - parameter completion: The closure to execute after the panel opens.
    */
    public func openLeftPanel(completion: ActionCompletion? = nil) {
        self.openPanel(.Left, withCompletion: completion)
    }
    
    /**
    Opens a panel for a side.
     
    - parameter side:       The panel side to open.
    - parameter completion: The closure to execute after the panel opens.
    */
    public func openPanel(side: Side, withCompletion completion: ActionCompletion? = nil) {
        guard let panelViewController = self.panelViewController(forSide: side) else {
            return
        }

        let openClosure: ActionCompletion = {
            self._panelSideDisplayed = SidePercentage(side: side, andPercentageVisible: 0)
            self._currentAction = .Opening(NSDate(), completion)
            self.displayLink?.paused = false

            let animatable = self.animation(forSide: side)
            let panelFrame = animatable.panelInitialFrame(forSlidingPanelController: self, andSide: side)
            let panelPositionViewHierarchy = animatable.panelPositionInViewHierarchy(forSlidingPanelController: self, andSide: side)
            
            self.addSlidingChildViewController(panelViewController, withViewInformation: ViewInformation(frame: panelFrame, panelPositionViewHierarchy: panelPositionViewHierarchy))            
        }

        if self.panelSideDisplayed != nil {
            self.closePanel(openClosure)
        } else {
            openClosure()
        }
    }
    
    /**
    Opens the right panel.
     
    - parameter completion: The closure to execute after the panel opens.
    */
    public func openRightPanel(completion: ActionCompletion? = nil) {
        self.openPanel(.Right, withCompletion: completion)
    }
    
    /**
    Opens the top panel.
     
    - parameter completion: The closure to execute after the panel opens.
    */
    public func openTopPanel(completion: ActionCompletion? = nil) {
        self.openPanel(.Top, withCompletion: completion)
    }
    
    // MARK: Tools
    
    /**
    Returns the animation instance associated to a panel side.
    
    - parameter side: The side.
    
    - returns: The animation instance for a side.
    */
    private func animation(forSide side: Side) -> SlidingPanelAnimatable {
        switch side {
        case .Left: return self._leftAnimation
        case .Right: return self._rightAnimation
        case .Top: return self._topAnimation
        case .Bottom: return self._bottomAnimation
        }
    }
    
    /**
    Returns the animation duration associated to a panel side.
     
    - parameter side: The side.
     
    - returns: The animation duration for a side.
    */
    public func animationDuration(forSide side: Side) -> NSTimeInterval {
        switch side {
        case.Left: return self.leftAnimationDuration
        case .Right: return self.rightAnimationDuration
        case .Top: return self.topAnimationDuration
        case .Bottom: return self.bottomAnimationDuration
        }
    }
    
    /**
    Checks if the storyboard initialization has been done correctly.
    It also removes the container views added to fill controllers (center, left, right, top and bottom).
    */
    private func checkStoryboardInitialization() {
        guard self._centerViewController != nil else {
            print("[SlidingPanelController]: The property \"centerViewController\" is not initialized. You probably forgot to:\n - add a container view with segue identifier \"\(Segue.Center.rawValue)\",\n - to link this container view with the IBOutlet \"_centerContainerView\".", toStream: &self._errorStream)
            exit(0)
        }
        
        self.removeContainerViews()
    }
    
    /**
    Returns the view associated to a panel side.
     
    - parameter side: The side.
     
    - returns: The view for the side.
    */
    public func panelView(forSide side: Side) -> UIView? {
        return self.panelViewController(forSide: side)?.view
    }
    
    /**
    Returns the controller associated to a panel side.
     
    - parameter side: The side.
     
    - returns: The controller for the side.
    */
    public func panelViewController(forSide side: Side) -> UIViewController? {
        switch side {
        case .Left: return self.leftViewController
        case .Right: return self.rightViewController
        case .Top: return self.topViewController
        case .Bottom: return self.bottomViewController
        }
    }
    
    /**
    Returns the view's frame associated to a panel side.
     
    - parameter side: The side.
     
    - returns: The frame for the side.
    */
    public func panelViewFrame(forSide side: Side) -> CGRect? {
        return self.panelView(forSide: side)?.frame
    }
    
    // MARK: Debug Tools
    
    /**
    Print on console a table with the controllers set.
    */
    private func summarizeControllersSet() {
        let centerViewControllerResult = self._centerViewController != nil ? "✓" : "✗"
        let leftViewControllerResult = self.leftViewController != nil ? "✓" : "✗"
        let rightViewControllerResult = self.rightViewController != nil ? "✓" : "✗"
        let topViewControllerResult = self.topViewController != nil ? "✓" : "✗"
        let bottomViewControllerResult = self.bottomViewController != nil ? "✓" : "✗"
        
        print("")
        print(" ------------------------------------")
        print("| Controllers set                    |")
        print("|------------------------------------|")
        print("| self._centerViewController     | \(centerViewControllerResult) |")
        print("| self.leftViewController        | \(leftViewControllerResult) |")
        print("| self.rightViewController       | \(rightViewControllerResult) |")
        print("| self.topViewController         | \(topViewControllerResult) |")
        print("| self.bottomViewController      | \(bottomViewControllerResult) |")
        print(" ------------------------------------\n")
    }
    
    /**
    Print on console a table with the controllers which have the sliding panel controller as parent.
    */
    private func summarizeControllersWithSlidingPanelControllerAsParent() {
        let centerViewControllerResult = self._centerViewController?.slidingPanelController == self ? "✓" : "✗"
        let leftViewControllerResult = self.leftViewController?.slidingPanelController == self ? "✓" : "✗"
        let rightViewControllerResult = self.rightViewController?.slidingPanelController == self ? "✓" : "✗"
        let topViewControllerResult = self.topViewController?.slidingPanelController == self ? "✓" : "✗"
        let bottomViewControllerResult = self.bottomViewController?.slidingPanelController == self ? "✓" : "✗"
        
        print("")
        print(" ------------------------------------")
        print("| Controllers with sliding parent    |")
        print("|------------------------------------|")
        print("| self._centerViewController     | \(centerViewControllerResult) |")
        print("| self.leftViewController        | \(leftViewControllerResult) |")
        print("| self.rightViewController       | \(rightViewControllerResult) |")
        print("| self.topViewController         | \(topViewControllerResult) |")
        print("| self.bottomViewController      | \(bottomViewControllerResult) |")
        print(" ------------------------------------\n")
    }
    
    /**
    Print on console a table with the controllers which have their view in view hierarchy.
    */
    private func summarizeControllersWithViewInHierarchy() {
        let centerViewControllerResult = self.centerView?.superview != nil ? "✓" : "✗"
        let leftViewControllerResult = self.leftView?.superview != nil ? "✓" : "✗"
        let rightViewControllerResult = self.rightView?.superview != nil ? "✓" : "✗"
        let topViewControllerResult = self.topView?.superview != nil ? "✓" : "✗"
        let bottomViewControllerResult = self.bottomView?.superview != nil ? "✓" : "✗"
        
        print("")
        print(" ------------------------------------")
        print("| Controllers with view in hierarchy |")
        print("|------------------------------------|")
        print("| self._centerViewController     | \(centerViewControllerResult) |")
        print("| self.leftViewController        | \(leftViewControllerResult) |")
        print("| self.rightViewController       | \(rightViewControllerResult) |")
        print("| self.topViewController         | \(topViewControllerResult) |")
        print("| self.bottomViewController      | \(bottomViewControllerResult) |")
        print(" ------------------------------------\n")
    }
    
    // MARK: Error
    
    /**
    Error stream.
    */
    private struct StderrOutputStream: OutputStreamType {
        
        /**
        Append the given string to this stream.
         
        - parameter string: The string which will be appened to the stream.
        */
        private func write(string: String) {
            fputs(string, stderr)
        }
    }
    
    /**
    The error stream (stderr).
    */
    private var _errorStream = StderrOutputStream()
    
    // MARK: Navigation Management
    
    /**
    Notifies the view controller that a segue is about to be performed.
    
    - parameter segue:  The segue object containing information about the view controllers involved in the segue.
    - parameter sender: The object that initiated the segue. You might use this parameter to perform different actions based on which control (or other object) initiated the segue.
    */
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier, spcSegue = Segue(rawValue: segueId) {
            switch spcSegue {
            case .Center: self.centerViewController = segue.destinationViewController
            case .Left: self.leftViewController = segue.destinationViewController
            case .Right: self.rightViewController = segue.destinationViewController
            case .Top: self.topViewController = segue.destinationViewController
            case .Bottom: self.bottomViewController = segue.destinationViewController
            }
        }
    }
    
    // MARK: Animation Management
    
    /**
    The link to synchronize the `SlidingPanelController` drawing to the refresh rate of the display.
    */
    private var displayLink: CADisplayLink!
    
    /**
    Sets up correctly the variable `displayLink`.
    */
    private func setUpDisplayLink() {
        guard let window = self.view.window else {
            print("[MSSlidingPanelController]: The controller is not able to set up its CADisplayLink. The controller's view is probably not contained into an \"UIWindow\".", toStream: &self._errorStream)
            exit(0)
        }
        
        self.displayLink = window.screen.displayLinkWithTarget(self, selector: "updateScreen")
        self.displayLink.paused = true
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    /**
    Called during animation when the screen have to be updated.
    */
    private dynamic func updateScreen() {
        guard let currentAction = self._currentAction, side = self.panelSideDisplayed where self.panelView(forSide: side) != nil else {
            return
        }

        let animation: SlidingPanelAnimatable = self.animation(forSide: side)
        let animationDuration: NSTimeInterval = self.animationDuration(forSide: side)

        let actionCompletion: ActionCompletion?
        var percentage: CGFloat = 0

        switch currentAction {
        case .Opening(let date, let completion) where date != nil:
            percentage = CGFloat(NSDate().timeIntervalSinceDate(date!) / animationDuration)
            actionCompletion = completion
        case .Closing(let date, let completion) where date != nil:
            percentage = CGFloat(1.0 - (NSDate().timeIntervalSinceDate(date!) / animationDuration))
            actionCompletion = completion
        default:
            return
        }

        if percentage > 1 {
            percentage = 1
        } else if percentage < 0 {
            percentage = 0
        }

        self.percentageVisibleForPanelDisplayed = percentage
        animation.animate(SlidingPanelController: self, withSide: side, andVisiblePercentage: percentage)

        if percentage >= 1 || percentage <= 0 {
            self.displayLink?.paused = true

            self._currentAction = nil
            actionCompletion?()
        }
    }
    
    // MARK: Child View Controllers Management
    
    /**
    Adds the center view controller and every panel as sliding child view controller.
    */
    private func addEveryViewControllersAsSlidingChildViewController() {
        if let leftViewController = self.leftViewController {
            self.addSlidingChildViewController(leftViewController, withViewInformation: nil)
        }
        
        if let rightViewController = self.rightViewController {
            self.addSlidingChildViewController(rightViewController, withViewInformation: nil)
        }
        
        if let topViewController = self.topViewController {
            self.addSlidingChildViewController(topViewController, withViewInformation: nil)
        }
        
        if let bottomViewController = self.bottomViewController {
            self.addSlidingChildViewController(bottomViewController, withViewInformation: nil)
        }
    }
    
    /**
    Adds a child view controller to `SlidingPanelController` and set its view.
    Warning: In case the `childViewController` is equal to `_centerViewController`, `panelPositionViewHierarchy` of `viewInformation` is not evaluated.
    
    - parameter childViewController: The child view controller.
    - parameter viewInformation:     Some information about the view, as its frame and its position compared to the center view.
    */
    private func addSlidingChildViewController(childViewController: UIViewController, withViewInformation viewInformation: ViewInformation?) {
        self.addChildViewController(childViewController)
        
        if let viewInformation = viewInformation {
            let childView = childViewController.view
            let parentView = self.view
            
            childView.frame = viewInformation.frame
            
            if childViewController === centerViewController {
                parentView.addSubview(childView)
            } else {
                switch viewInformation.panelPositionViewHierarchy {
                case .AboveCenterView: parentView.insertSubview(childView, aboveSubview: self.centerView)
                case .BelowCenterView: parentView.insertSubview(childView, belowSubview: self.centerView)
                }
            }
        }
        
        childViewController.didMoveToParentViewController(self)
    }
    
    /**
    Removes the container views added to fill controllers (center, left, right, top and bottom).
    */
    private func removeContainerViews() {
        self._centerContainerView?.removeFromSuperview()
        
        self._leftContainerView?.removeFromSuperview()
        self.leftView?.removeFromSuperview()
        
        self._rightContainerView?.removeFromSuperview()
        self.rightView?.removeFromSuperview()
        
        self._topContainerView?.removeFromSuperview()
        self.topView?.removeFromSuperview()
        
        self._bottomContainerView?.removeFromSuperview()
        self.bottomView?.removeFromSuperview()
    }
    
    /**
    Removes a child view controller from `SlidingPanelController`.
     
    - parameter childViewController: The child view controller.
    - parameter view:                The child view to remove, if it is not `childViewController.view`.
    */
    private func removeSlidingChildViewController(childViewController: UIViewController, withView view: UIView? = nil) {
        let childView = view ?? childViewController.view
        
        childViewController.willMoveToParentViewController(nil)
        childView?.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
}
