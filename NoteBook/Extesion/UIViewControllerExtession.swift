//
//  UIViewControllerExtession.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import Foundation
import UIKit
extension UIViewController {
    
    func addBackBarButtonItem(imageNamed: String = "nav_left_b", title:String?, action: Selector = #selector(backBarButtonItemTapped)) {
        var curTitle: String? = title
        var image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
        
        if self.navigationController != nil {
            let index = self.navigationController!.viewControllers.count - 2
            
            if index >= 0 && index < self.navigationController!.viewControllers.count {
                let upVC = self.navigationController!.viewControllers[index]
                if title == nil {
                    curTitle = upVC.title
                }
            }
            
            if index == -1 {
                image = nil
            }
        }
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        button.tintColor = UIColor.hex(hexString: "#333333")
        button.setImage(image, for: .normal)
        button.setTitle(curTitle, for: .normal)
        button.setTitleColor(UIColor.hex(hexString: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont.fontAlibabaPuHuiTiM(size: 18)
        button.addTarget(self, action: action, for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    func addBackBarButtonItem(imageNamed: String = "nav_left_b", action: Selector = #selector(backBarButtonItemTapped)) {

        var image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal)
        
        if self.navigationController != nil {
            let index = self.navigationController!.viewControllers.count - 2
            
            if index == -1 {
                image = nil
            }
        }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button.contentHorizontalAlignment = .left
//        button.tintColor = UIColor.hex(hexString: "#333333")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.navigationBar.barTintColor = .white
    }
}

fileprivate extension UIViewController {
    @objc func backBarButtonItemTapped() {
        nt_playVoice(resource: "a14-返回按钮")
        if (self.navigationController?.popViewController(animated: true) == nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
