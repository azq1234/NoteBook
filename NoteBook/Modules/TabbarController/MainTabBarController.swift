//
//  MainTabBarController.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import UIKit

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {
    //MARK: 初始化数据
    
    private lazy var imageNames : [String] = {
        return ["h1", "h2", "h3","h3", "h4"]
    }()
    private lazy var simageNames : [String] = {
        return ["LivePhotoLight", "LivePhotoLight", "LivePhotoLight","LivePhotoLight", "LivePhotoLight"]
    }()
    private lazy var titleNames : [String] = {
        return ["首页", "大厅", "主题","圈子","我的"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildVCWithImg(childVC: BaseNavigationController(rootViewController: ViewController()), childTitle: titleNames[0], imageName: imageNames[0], selectedImageName: simageNames[0], index: 0)
    
        self.addChildVCWithImg(childVC: BaseNavigationController(rootViewController: ViewController()), childTitle: titleNames[1], imageName: imageNames[1], selectedImageName: simageNames[1], index: 1)
        
        self.addChildVCWithImg(childVC: BaseNavigationController(rootViewController: ViewController()), childTitle: titleNames[2], imageName: imageNames[2], selectedImageName: simageNames[2], index: 2)
        
        self.addChildVCWithImg(childVC: BaseNavigationController(rootViewController: ViewController()), childTitle: titleNames[3], imageName: imageNames[3], selectedImageName: simageNames[3], index: 3)
        
        self.addChildVCWithImg(childVC: BaseNavigationController(rootViewController: NTMineViewController()), childTitle: titleNames[4], imageName: imageNames[4], selectedImageName: simageNames[4], index: 4)
        
        if #available(iOS 11.0, *) {
            self.view.insetsLayoutMarginsFromSafeArea = false
        }
        UITabBarItem.appearance()
        .setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.fontAlibabaPuHuiTiR(size: 12)], for: .normal)
        
        //创建自己的tabbar，然后用KVC将自己的tabbar和系统的tabBar替换下
        let mtabbar = MainTabBar()

        //KVC实质是修改了系统的_tabBar
        self.setValue(mtabbar, forKeyPath: "tabBar")
       
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//       if nil == CPT_User.getUsermodel() && viewController == self.children[4] {
//           self.loginClickedAction()
//           return false
//       }
//       if viewController == self.children[4]
//       {
//           NotificationCenter.default.post(name: NSNotification.Name(notificationRequestMemberInfoAccountInfo), object: self, userInfo: nil)
//       }
       return true
   }
   
   func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       nt_playVoice(resource: "a01-底部一级按钮",type: "mp3")
   }
   
   func loginClickedAction() {
//       let v = CPT_LoginView(frame: UIScreen.main.bounds)
//       UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(v)
   }
}
extension MainTabBarController {
    private func addChildVCWithImg(childVC: UIViewController, childTitle: String, imageName: String ,selectedImageName:String , index: Int){
        
        childVC.title = childTitle
        childVC.tabBarItem.tag = index
        
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.addChild(childVC)
        
    }
}
