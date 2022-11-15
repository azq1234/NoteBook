//
//  MBProgressHUD+Extension.swift
//  CPTProduct
//
//  Created by Larson on 2020/6/4.
//  Copyright © 2020 Mr.Li. All rights reserved.
//

import Foundation
extension MBProgressHUD {
    
    static var  currentHud : MBProgressHUD? = nil
    
    class func showLoading(title: String? = nil, toView: UIView? = nil) {
        let hud = MBProgressHUD.creatHud(toView)
        hud.bezelView.style = .solidColor
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:[MBProgressHUD.self]).color = .hex(hexString: "#3274F5")
        hud.bezelView.color = .hex(hexString: "#f5f5f5") //将提示框背景改成透明
        hud.removeFromSuperViewOnHide = true
        hud.label.text = title
        currentHud = hud
    }
    
    class func showRLoading(title: String? = nil, toView: UIView? = nil) ->(MBProgressHUD) {
        let hud = MBProgressHUD.creatHud(toView)
        hud.bezelView.style = .solidColor
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:[MBProgressHUD.self]).color = .hex(hexString: "#3274F5")
        hud.bezelView.color = .hex(hexString: "#f5f5f5") //将提示框背景改成透明
        hud.removeFromSuperViewOnHide = true
        hud.label.text = title
        currentHud = hud
        
        return hud
    }
    

    class func hideLoadind (_ toView: UIView? = nil) {
        let view: UIView! = toView ?? viewToShow()
        MBProgressHUD.hide(for: view!, animated: false)
        currentHud = nil;
    }
    
    class func creatHud (_ toView: UIView? =  UIApplication.shared.keyWindow ) -> MBProgressHUD {
        let view: UIView? = toView ?? viewToShow()
        if nil != currentHud {
            MBProgressHUD.hide(for: view!, animated: true)
            currentHud = nil;
        }
        let hud = MBProgressHUD.showAdded(to: view!, animated: false)
        currentHud = hud
        return hud
    }

    ///显示等待消息
    class func showWait(_ title: String) {
        let hud = MBProgressHUD.creatHud()
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }
    
    ///显示普通消息
    class func showInfo(_ title: String) {
        let hud = MBProgressHUD.creatHud()
        hud.mode = .customView //模式设置为自定义视图
        if  let image = UIImage(named: "warning") {
            hud.customView = UIImageView(image: image) //自定义视图显示图片
        }
        
        hud.label.numberOfLines = 0
        hud.label.lineBreakMode = .byCharWrapping
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    
    
    ///显示普通消息
    class func showInfo(title: String) {
        let hud = MBProgressHUD.creatHud()
        hud.mode = .customView //模式设置为自定义视图
        if  let image = UIImage(named: "warning") {
            hud.customView = UIImageView(image: image) //自定义视图显示图片
        }
        hud.detailsLabel.text = title
        hud.detailsLabel.numberOfLines = 0
        hud.detailsLabel.lineBreakMode = .byCharWrapping
        hud.detailsLabel.font = UIFont.fontAlibabaPuHuiTiM(size: 16)
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    ///显示成功消息
    class func showSuccess(_ title: String) {
        let hud = MBProgressHUD.creatHud()
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "red_true"))//自定义视图显示图片red_true
        hud.label.text = title
        hud.label.numberOfLines = 0
        hud.label.lineBreakMode = .byCharWrapping
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 3)
    }
    
    //显示失败消息
    class func showError(_ title: String) {
        let hud = MBProgressHUD.creatHud()
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "error")) //自定义视图显示图片
        hud.label.text = title
        hud.label.numberOfLines = 0
        hud.label.lineBreakMode = .byCharWrapping
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 3)
    }
    
    //获取用于显示提示框的view
    class func viewToShow() -> UIView? {
        let windows = UIApplication.shared.windows
        if let vue = windows.first{
            return vue
        }
        return nil
    }
    
 
}


 
