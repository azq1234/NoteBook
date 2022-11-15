//
//  AppDelegate.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//

import UIKit
import JJException

let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var blockRotation: UIInterfaceOrientationMask = .portrait{
        didSet{
            if blockRotation.contains(.portrait){
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") //强制设置成竖屏
            }else{
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") //强制设置成横屏
            }
        }
    }
    var window: UIWindow?
    var tabBarController: MainTabBarController? {
        if ((self.window?.rootViewController?.isKind(of: MainTabBarController.self)) != nil) {
            return  self.window?.rootViewController as? MainTabBarController
        }
        return nil
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        return true
    }


}

extension AppDelegate {
    func setRootViewController()  {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        let d = Defaults()
        let firstLaunch = ((d.get(for: kFirstLaunchKey) ?? "YES") as NSString).boolValue
        if firstLaunch{
            let d = Defaults()
            d.set("NO", for: kFirstLaunchKey)
//            let launchVc = CPT_LaunchAdViewController()
//            CPT_LianluView.show(version: "链路切换", updateUrl: "https://www.baidu.com")
//            self.window?.rootViewController = launchVc
        }else{
            let tabBarController = MainTabBarController()
            self.window?.rootViewController = tabBarController
        }
        window?.backgroundColor = .white
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        self.window?.makeKeyAndVisible()
    }
}
