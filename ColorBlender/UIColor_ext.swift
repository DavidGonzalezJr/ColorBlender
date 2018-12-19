//
//  UIColor_ext.swift
//  ColorBlender
//
//  Created by David Gonzalez Jr on 4/18/18.
//  Copyright © 2018 David Gonzalez Jr. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //Return the color components of the UIColor Object
    func RGBA() -> (red: Float, green: Float, blue: Float, alpha: Float) {
        
        let colorValues:[CGFloat] = self.cgColor.components!
        
        return (Float(colorValues[0]), Float(colorValues[1]), Float(colorValues[2]), Float(colorValues[3]))
        
    }
    
    //Return the color components of the UIColor Object
    func cgRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        let colorValues:[CGFloat] = self.cgColor.components!
        
        return (colorValues[0], colorValues[1], colorValues[2], colorValues[3])
        
    }
    
}
