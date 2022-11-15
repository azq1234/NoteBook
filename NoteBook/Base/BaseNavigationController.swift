//
//  BaseNavigationController.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate  {
    var popDelegate: UIGestureRecognizerDelegate?
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*****  解决自定义导航栏后侧滑返回功能失效解决办法  **** */
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        /*****  解决自定义导航栏后侧滑返回功能失效解决办法  **** */
        // Do any additional setup after loading the view.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if self.viewControllers.count>1 {
            viewController.hidesBottomBarWhenPushed = true
        } else{
            viewController.hidesBottomBarWhenPushed = false
        }
        
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }


}
extension BaseNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
}
