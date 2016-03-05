//
//  UIColor+hex.swift
//  Tsuitta
//
//  Created by jaco on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func hex (var hexStr : NSString, alpha : CGFloat) -> UIColor {
        
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
            
        } else {
            
            print("invalid hex string", terminator: "")
            return UIColor.whiteColor()
            
        }
        
    }
    
}