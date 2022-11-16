//
//  NT_SystemTime.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
import UIKit


///  矫正手机系统和服务器的时间
class NT_SystemTime{
    static  let sharedInstance: NT_SystemTime = {
        let instance = NT_SystemTime()
        return instance
    }()
    
    private(set) var systemTime: TimeInterval = 0.0

    
    class func updateSystemTime(response: HTTPURLResponse?) {
        guard NT_SystemTime.sharedInstance.systemTime == 0 else {return}
        if let allHeaderFields = response?.allHeaderFields {
            if let dateStr: String = allHeaderFields[AnyHashable("Date")] as? String {
                NSLog("Date: " + dateStr)
                let systemDate = Date.string(format: "E, dd MMM yyyy HH:mm:ss zzz", timestamp: dateStr)
                if (systemDate != nil) {
                    NT_SystemTime.sharedInstance.systemTime = systemDate!.timeIntervalSince1970
                }
            }
        }
    }
}
