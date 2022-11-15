//
//  UIFontExtession.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import Foundation
import UIKit
extension UIFont {
    static func fontAlibabaPuHuiTiR(size:CGFloat) ->UIFont{
      return CPT_systemFont(size: size)
//        return UIFont.init(name:"AlibabaPuHuiTi-Regular", size: size)!

    }
    
    static func fontAlibabaPuHuiTiM(size:CGFloat) ->UIFont{
      return CPT_systemFont(size: size)
//           return UIFont.init(name:"AlibabaPuHuiTi-Medium", size: size)!

    }
    
    static func fontAlibabaPuHuiTiL(size:CGFloat) ->UIFont{
 return CPT_systemFont(size: size)
//           return UIFont.init(name:"AlibabaPuHuiTi-Light", size: size)!

    }
    
    static func fontAlibabaPuHuiTiB(size:CGFloat) ->UIFont{
             return CPT_systemFont(size: size)
//           return UIFont.init(name:"AlibabaPuHuiTi-Bold", size: size)!

    }
    
    static func fontRobotoR(size:CGFloat) ->UIFont{
            return CPT_systemFont(size: size)
//           return UIFont.init(name:"Roboto-Regular", size: size)!

    }
    
    static func fontRobotoM(size:CGFloat) ->UIFont{
            return CPT_systemFont(size: size)
//           return UIFont.init(name:"Roboto-Medium", size: size)!

    }
    static func fontLiquidCrystal(size:CGFloat) ->UIFont{
     return CPT_systemFont(size: size)
//            return UIFont.init(name:"LiquidCrystal", size: size)!

    }
    private static func CPT_systemFont(size:CGFloat)->UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}
