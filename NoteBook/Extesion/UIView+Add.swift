//
//  UIView+Add.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit
extension UIView {
    
    /// 获取xib视图
    /// - Parameters:
    ///   - name: xib名
    ///   - index: 视图索引（xib允许存在多个独立view）
    /// - Returns: 对应视图
    class func xibView(_ name: String, index: Int = 0) -> UIView {
        let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[index]
        return view as! UIView
    }
    
    /// 获取xib视图
    /// - Parameters:
    ///   - index: 视图索引（xib允许存在多个独立view）
    /// - Returns: 对应视图
    class func xibView(index: Int = 0) -> UIView {
        let view = Bundle.main.loadNibNamed(self.className(), owner: nil, options: nil)?[index]
        return view as! UIView
    }
    
    /// 部分圆角
    ///
    /// -Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, strokeColor: UIColor?) {
        let layerName: String = "nt_cornerLayer"
        let bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let maskPath = UIBezierPath(roundedRect:bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        if strokeColor != nil {
            if let sublayers = self.layer.sublayers {
                for sublayer in sublayers {
                    if sublayer.name == layerName {
                        sublayer.removeFromSuperlayer()
                    }
                }
            }
            let borderLayer = CAShapeLayer()
            borderLayer.lineWidth = 1.0
            borderLayer.lineCap = CAShapeLayerLineCap.square
            borderLayer.strokeColor = strokeColor?.cgColor;
            borderLayer.fillColor = UIColor.clear.cgColor;
            borderLayer.frame = bounds
            borderLayer.path = maskPath.cgPath
            self.layer.addSublayer(borderLayer)
        }
    }
    
    // 部分圆角阴影
    ///
    /// -Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, shadowColor: UIColor?) {
        let layerName: String = "nt_cornerLayer"
        let bounds = self.bounds
        let maskPath = UIBezierPath(roundedRect:bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        if shadowColor != nil {
            if let sublayers = self.layer.sublayers {
                for sublayer in sublayers {
                    if sublayer.name == layerName {
                        sublayer.removeFromSuperlayer()
                    }
                }
            }
            let borderLayer = CAShapeLayer()
            borderLayer.name = layerName
            borderLayer.frame = bounds
            borderLayer.path = maskPath.cgPath
            borderLayer.fillColor = UIColor.white.cgColor;
            borderLayer.shadowPath = maskPath.cgPath
            borderLayer.shadowColor = shadowColor?.cgColor
            borderLayer.shadowOffset = CGSize(width: 1, height: 1)
            borderLayer.shadowOpacity = 0.5
            borderLayer.shadowRadius = 2.0
            self.layer.insertSublayer(borderLayer, at: 0)
        }
    }
    
    /// 部分圆角+阴影(若frame不固定需放到layoutSubviews)
    ///
    /// -Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(_ corners: UIRectCorner, radii: CGFloat, strokeColor: UIColor? = nil, shadowColor: UIColor? = nil) {
        let layerName: String = "nt_corners_layerName"
        let maskPath = UIBezierPath(roundedRect:bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        // 部分圆角处理
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        guard (strokeColor != nil || shadowColor != nil) else {return}
        // 线框和阴影
        var borderLayer:CAShapeLayer?
        if let sublayers = self.layer.sublayers {
            for sublayer in sublayers {
                if sublayer.name == layerName {
                    borderLayer = sublayer as? CAShapeLayer; break
                }
            }
        }
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
        }
        if let layer = borderLayer {
            layer.name = layerName
            layer.frame = self.frame
            layer.path = maskPath.cgPath
            layer.fillColor = UIColor.clear.cgColor;
            if shadowColor != nil {
                layer.shadowPath = maskPath.cgPath
                layer.shadowColor = shadowColor?.cgColor
                layer.shadowOffset = CGSize(width: 1, height: 1)
                layer.shadowOpacity = 0.5
                layer.shadowRadius = 2.0
            }
            if strokeColor != nil {
                layer.lineWidth = 1.0
                layer.lineCap = CAShapeLayerLineCap.square
                layer.strokeColor = strokeColor?.cgColor;
            }
            self.superview?.layer.insertSublayer(layer, below: self.layer)
        }
    }
    
    /// 箭头向上的三角形
    func gx_triangle() {
        let rect = self.bounds
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: rect.size.height))
        trianglePath.addLine(to: CGPoint(x: rect.width/2, y: 0))
        trianglePath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        trianglePath.close()
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = trianglePath.cgPath
        maskLayer.fillColor = UIColor.green.cgColor
        self.layer.mask = maskLayer
    }
}
