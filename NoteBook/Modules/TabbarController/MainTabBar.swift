//
//  MainTabBar.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import UIKit


//无参无返回值
typealias funcBlock = () -> () //或者 () -> Void
class MainTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayer()

        self.tintColor = .hex(hexString: "#BC9B7A")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainTabBar {
    
    
    fileprivate func setLayer() {
        
        self.backgroundColor = UIColor.hex(hexString: "#FFFFFF")
        //
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
        
        self.cornerRadius = 25
        
        
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 48 + kBottomH)
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 25.0, height: 25.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect//self.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shadowColor = UIColor.hexWithAlpha(hexString: "#000000",alpha:1).cgColor
        maskLayer.shadowOffset = CGSize(width: 0, height: 2)
        maskLayer.shadowOpacity = 0.16
        maskLayer.shadowRadius = 25
        maskLayer.masksToBounds = false
        //        maskLayer.backgroundColor = UIColor.yellow.cgColor
        maskLayer.fillColor = UIColor.white.cgColor
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        self.layer.insertSublayer(maskLayer, at: 0)
        
    }

}
 
