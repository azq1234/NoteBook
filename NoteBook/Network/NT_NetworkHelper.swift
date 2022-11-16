//
//  NT_NetworkHelper.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
let d = Defaults()

class NT_NetworkHelper: NSObject {

    //ip
    class func getClientIp() -> String{
        return IpUntils.getIPAddresses() ?? ""
    }
    
    ///设备名 、os
    class func getDeviceName_OS() -> String{
        return UIDevice.deviceName_OS()
    }
    
    //version
    class func getAppVersion() -> String{
        let infoDic = Bundle.main.infoDictionary
        return (infoDic?["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    class func getAuthToken() -> String{
        return "token" ?? ""  //d.get(for: kTokenKey) ?? ""
    }
    
    class func getSign() -> String{
        let timeStr:String = Date.stringDate()
        let cardinal:String = String(format: "%@,%@","IDTent",timeStr)
        let sign:String = cardinal.sha256
        return sign
    }
}

extension String {
    var sha256: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
}

