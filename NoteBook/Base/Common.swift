//
//  Common.swift
//  NoteBook
//
//  Created by admin on 2022/11/14.
//
import UIKit
import AudioToolbox

func ScaleF(x:CGFloat) -> CGFloat{
    return x*Scale
}

func ScaleHF(y:CGFloat) -> CGFloat{
    return y*ScaleH
}


// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
///状态栏高度
let kTopStatuH = UIApplication.shared.statusBarFrame.size.height

let kNavitionbarH:CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 88 : 64
///设备是异形屏苹果手机
let KDevice_Is_FullPhone = kNavitionbarH == 64 ? false : true
///底部安全区域
let kBottomH:CGFloat = KDevice_Is_FullPhone ? 34.0 : 0.0
///tabber的高度
let KTabBarH:CGFloat = KDevice_Is_FullPhone ? 83.0 : 49.0
///宽度缩放系数
let Scale = kScreenW/375.0
let ScaleH = kScreenH/667.0
////适配iPhoneX
//let is_iPhoneX = (kScreenW == 375.0 && kScreenH == 812.0 ? true : false)
//let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
//let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
//let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
//let iPhoneXBottomH: CGFloat = 34.0
//let iPhoneXTopH: CGFloat = 24.0

// MARK:- notificationName通知名
///通知名 是否阻断BetSlipsCell监听自定义键盘是否弹出
//let IsMonitorBetSlipsCellKeyboard = Notification.Name("IsMonitorBetSlipsCellKeyboard")
/////通知名 接收通知删除某一投注单
//let CancelOneBetSlips = Notification.Name("CancelOneBetSlips")
/////通知名 添加某一投注单
//let AddOneBetSlips = Notification.Name("AddOneBetSlips")
/////通知名 通知MainViewController添加投注单视图
//let AddBetSlipsView = Notification.Name("AddBetSlipsView")
/////通知名 通知IMChat进行了减秒操作
//let KIMChatTimeCountdown = Notification.Name("IMChatTimeCountdown")

// MARK:- 常量
struct MetricGlobal {
    static let padding: CGFloat = 10.0
    static let margin: CGFloat = 10.0
}

// MARK:-应用程序信息
private let infoDictionary = Bundle.main.infoDictionary!
///程序名称
let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
///主程序版本号
let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
///版本号（内部标示）
let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
///app版本号 String
let AppVersion = majorVersion as! String
//****通知****
//通知 请求 MemberInfo AccountInfo
let notificationRequestMemberInfoAccountInfo = "NotificationRequestMemberInfoAccountInfo"
//通知 重装 MemberInfo
let notificationRemakeMemberInfo = "NotificationRemakeMemberInfo"
//通知 重装  AccountInfo
let notificationRemakeAccountInfo = "NotificationRemakeAccountInfo"
//通知 刷新未读消息的通知
let notificationRefreshUnreadMsg = "notificationRefreshUnreadMsg"
 


// MARK:- 颜色方法
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK:- 常用按钮颜色
// 颜色参考 http://www.sioe.cn/yingyong/yanse-rgb-16/




// MARK:- 当前的最上层的VC
var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}



struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}


///字典转JSON字符串
func convertDictionaryToJSONString(dict:NSDictionary?)->String {
    if (!JSONSerialization.isValidJSONObject(dict!)) {
        NSLog("无法解析出JSONString")
        return ""
    }
    let data = try? JSONSerialization.data(withJSONObject: dict!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    return jsonStr! as String
}
///JSON转字典
func convertJSONStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
        } catch let error as NSError {
            
        }
    }
    return nil
}


func nt_playVoice(resource:String, type:String = "wav") {
//    if ((UserDefaults.standard.string(forKey: "xx_voice")!) as NSString).boolValue == false {
//        return
//    }
//    //建立的SystemSoundID对象
//    var soundID:SystemSoundID = 0
//    //获取声音地址
//    let path = Bundle.main.path(forResource: resource, ofType: type)
//    //地址转换
//    let baseURL = NSURL(fileURLWithPath: path!)
//    //赋值
//    AudioServicesCreateSystemSoundID(baseURL, &soundID)
//    //播放声音
//    AudioServicesPlaySystemSound(soundID)
}

