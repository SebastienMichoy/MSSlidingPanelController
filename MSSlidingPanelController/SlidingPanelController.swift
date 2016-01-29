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
The `SlidingPanelController` is a class that manages panels. It is possible to add until 4 panels (top, left, right and bottom) and to display and hide them with several animations.
*/
public final class SlidingPanelController: UIViewController {
    
    // MARK: Type Alias
    
    typealias ViewInformation = (frame: CGRect, index: Int)
    
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
        
        self.view.addSubview(self._centerHitView)
        self._centerHitView.frame = self.view.frame
        
        self.addSlidingChildViewController(centerViewController, withViewInformation: (frame: self._centerHitView.bounds, index: 0))
    }
    
    // MARK: Navigation Management
    
    /**
    Notifies the view controller that a segue is about to be performed.
    
    - parameter segue:  The segue object containing information about the view controllers involved in the segue.
    - parameter sender: The object that initiated the segue. You might use this parameter to perform different actions based on which control (or other object) initiated the segue.
    */
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier, spcSegue = Segue(rawValue: segueId) {
            switch spcSegue {
            case .Center:
                self.centerViewController = segue.destinationViewController
            case .Left:
                self.leftViewController = segue.destinationViewController
            case .Right:
                self.rightViewController = segue.destinationViewController
            case .Top:
                self.topViewController = segue.destinationViewController
            case .Bottom:
                self.bottomViewController = segue.destinationViewController
            }
        }
    }
    
    // MARK: Controller Information
    
    /**
    Indicates if the initialization has been done via storyboard.
    */
    private var _initializedViaStoryboard: Bool {
        return self.nibName != nil
    }
    
    // MARK: Center View Controller
    
    /**
    The center container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _centerContainerView: UIView!
    
    /**
    A view which manages touches on the center view.
    */
    private var _centerHitView: UIView = UIView()
    
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
                self.removeSlidingChildViewController(centerViewController, withView: centerViewController.view)
            }
        }
        
        didSet {
            if let centerViewController = self._centerViewController {
                self.addSlidingChildViewController(centerViewController, withViewInformation: (frame: self._centerHitView.bounds, index: 0))
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
    
    // MARK: Left View Controller
    
    /**
    The left container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _leftContainerView: UIView!
    
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
            var viewInformation: ViewInformation? = nil
            
            if let leftViewController = self.leftViewController {
                if let leftView = self.leftView, index = self.view.subviews.indexOf(leftView) {
                    viewInformation = ViewInformation(frame: leftView.frame, index: index)
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
    The right container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _rightContainerView: UIView!
    
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
            var viewInformation: ViewInformation? = nil
            
            if let rightViewController = self.rightViewController {
                if let rightView = self.rightView, index = self.view.subviews.indexOf(rightView) {
                    viewInformation = ViewInformation(frame: rightView.frame, index: index)
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
    The top container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _topContainerView: UIView!
    
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
            var viewInformation: ViewInformation? = nil
            
            if let topViewController = self.topViewController {
                if let topView = self.topView, index = self.view.subviews.indexOf(topView) {
                    viewInformation = ViewInformation(frame: topView.frame, index: index)
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
    The bottom container view. It is used to remove the view when the controller is initialized via storyboard.
    */
    @IBOutlet private var _bottomContainerView: UIView!
    
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
            var viewInformation: ViewInformation? = nil
            
            if let bottomViewController = self.bottomViewController {
                if let bottomView = self.bottomView, index = self.view.subviews.indexOf(bottomView) {
                    viewInformation = ViewInformation(frame: bottomView.frame, index: index)
                }
                
                self.removeSlidingChildViewController(bottomViewController, withView: self.bottomView)
            }
            
            if let newBottomViewController = newValue {
                self.addSlidingChildViewController(newBottomViewController, withViewInformation: viewInformation)
            }
        }
    }
    
    // MARK: Child View Controllers Management
    
    /**
    Adds a child view controller to `SlidingPanelController` and set its view.
    
    - parameter childViewController: The child view controller.
    - parameter viewInformation:     Some information about the view, as its frame and its index as subview.
    */
    private func addSlidingChildViewController(childViewController: UIViewController, withViewInformation viewInformation: ViewInformation?) {
        self.addChildViewController(childViewController)
        
        if let viewInformation = viewInformation {
            let childView = childViewController.view
            let parentView = (childViewController == self.centerViewController) ? self._centerHitView : self.view
            
            childView.frame = viewInformation.frame
            parentView.insertSubview(childView, atIndex: viewInformation.index)
        }
        
        childViewController.didMoveToParentViewController(self)
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
    
    // MARK: Tools
    
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
}
