//
//  UIColorExtession.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import Foundation
import UIKit
extension UIColor {
    public convenience init(hexString: String) {
      let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
      let scanner   = Scanner(string: hexString)

      if hexString.hasPrefix("#") {
        scanner.scanLocation = 1
      }

      var color: UInt32 = 0

      if scanner.scanHexInt32(&color) {
        self.init(hex: color, useAlpha: hexString.count > 7)
      }
      else {
        self.init(hex: 0x000000)
      }
    }
    public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
       let mask = 0xFF

       let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
       let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
       let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
       let a = alphaChannel ? Int(hex) & mask : 255

       let red   = CGFloat(r) / 255
       let green = CGFloat(g) / 255
       let blue  = CGFloat(b) / 255
       let alpha = CGFloat(a) / 255

       self.init(red: red, green: green, blue: blue, alpha: alpha)
     }
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    ///随机色
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func image(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
    
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func hex(hexString: String) -> UIColor {
        return self.hexWithAlpha(hexString: hexString, alpha: 1.0)
    }
    
    class func hexWithAlpha(hexString: String, alpha:CGFloat) -> UIColor{
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b, a: alpha)
    }
}
