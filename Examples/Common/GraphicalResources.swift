//
//  GraphicalResources.swift
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

public class GraphicalResources : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfMenuIcon: UIImage?
        static var menuIconTargets: [AnyObject]?
    }

    //// Drawing Methods

    public class func drawMenuIcon() {
        //// Color Declarations
        let menuButtonColor = UIColor(red: 0.123, green: 0.123, blue: 0.123, alpha: 1.000)

        //// Menu Icon Group
        //// Bottom Drawing
        let bottomPath = UIBezierPath(roundedRect: CGRectMake(0, 14.5, 22, 3.5), cornerRadius: 1.75)
        menuButtonColor.setFill()
        bottomPath.fill()


        //// Middle Drawing
        let middlePath = UIBezierPath(roundedRect: CGRectMake(0, 7.25, 22, 3.5), cornerRadius: 1.75)
        menuButtonColor.setFill()
        middlePath.fill()


        //// Top Drawing
        let topPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 22, 3.5), cornerRadius: 1.75)
        menuButtonColor.setFill()
        topPath.fill()
    }

    //// Generated Images

    public class var imageOfMenuIcon: UIImage {
        if Cache.imageOfMenuIcon != nil {
            return Cache.imageOfMenuIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(22, 18), false, 0)
            GraphicalResources.drawMenuIcon()

        Cache.imageOfMenuIcon = UIGraphicsGetImageFromCurrentImageContext().imageWithRenderingMode(.AlwaysOriginal)
        UIGraphicsEndImageContext()

        return Cache.imageOfMenuIcon!
    }

    //// Customization Infrastructure

    @IBOutlet var menuIconTargets: [AnyObject]! {
        get { return Cache.menuIconTargets }
        set {
            Cache.menuIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: GraphicalResources.imageOfMenuIcon)
            }
        }
    }

}
