//
//  UIImageExtesion.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import Foundation
import UIKit
enum CPTGradientStyle {
    case linearHorizontal
    case linearVertical
    case obliqueUp
    case obliqueDown
}
extension UIImage {
    convenience init?(gradientColors:[UIColor], style:CPTGradientStyle, size:CGSize = CGSize(width: 10, height: 10))
    {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject?} as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        let start: CGPoint
        let end: CGPoint
        switch style {
            case CPTGradientStyle.linearHorizontal:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: size.width, y: 0)
            break
            case CPTGradientStyle.linearVertical:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x:0, y: size.height)
            break
            case CPTGradientStyle.obliqueUp:
            start = CGPoint(x: 0, y: size.height)
            end = CGPoint(x:size.width, y: 0)
            break
            case CPTGradientStyle.obliqueDown:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x:size.width, y: size.height)
            break
        }
        context?.drawLinearGradient(gradient!, start: start, end: end, options: CGGradientDrawingOptions(rawValue: 0))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {return nil}
        UIGraphicsEndImageContext()
        self.init(cgImage:cgImage)
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {return nil}
        UIGraphicsEndImageContext()
        self.init(cgImage:cgImage)
    }
}
