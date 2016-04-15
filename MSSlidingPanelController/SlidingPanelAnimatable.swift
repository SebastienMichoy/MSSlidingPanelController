//
//  SlidingPanelAnimatable.swift
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
The `SlidingPanelAnimatable` protocol is adopted by an object that will describe the animation for a panel of `SlidingPanelController`.
*/
public protocol SlidingPanelAnimatable {
    
    /**
    Asks the sliding panel animatable to set up views during the animation.
    In most cases, this set up will be done in function of the visible percentage.
     
    - parameter slidingPanelController: The sliding panel controller which contains the panel.
    - parameter side:                   The side of the panel.
    - parameter percentage:             The visible percentage of the panel.
    */
    func animate(slidingPanelController slidingPanelController: SlidingPanelController, withSide side: SlidingPanelController.Side, andVisiblePercentage percentage: CGFloat)
    
    /**
    Asks the initial frame of a panel in order to add it in the view hierarchy.
    This method is called right before the view is added in the view hierarchy.
     
    - parameter slidingPanelController: The sliding panel controller which contains the panel.
    - parameter side:                   The panel side.
     
    - returns: The panel initial frame.
    */
    func panelInitialFrame(forSlidingPanelController slidingPanelController: SlidingPanelController, andSide side: SlidingPanelController.Side) -> CGRect
    
    /**
    Asks whether the panel have to be added in the view herarchy above or below the center view.
    This method is called right before the view is added in the view hierarchy.
     
    - parameter slidingPanelController: The sliding panel controller which contains the panel.
    - parameter side:                   The panel side.
     
    - returns: The panel position compared to the center view.
    */
    func panelPositionInViewHierarchy(forSlidingPanelController slidingPanelController: SlidingPanelController, andSide side: SlidingPanelController.Side) -> SlidingPanelController.PanelPositionViewHierarchy
}
