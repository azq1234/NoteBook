//
//  IpUtils.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
import SystemConfiguration

var currentIP :String?
class IpUntils: NSObject {
    
    public class func getIPAddresses() -> String? {
        if let ip = currentIP {
            return ip
        }
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    
    
    
    static func getPublicIP(){
        let queue = OperationQueue()
        let blockOP = BlockOperation.init {
            if let url = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8") ,
               // TODO: 此处闪退
                let s = try? String(contentsOf: url, encoding: String.Encoding.utf8) {
                NSLog("data:\(s)")
                let subArr = s.components(separatedBy: ":")
                if subArr.count > 1  {
                    let ipStr = subArr[1].replacingOccurrences(of: "\"", with: "")
                    let ipSubArr = ipStr.components(separatedBy: ",")
                    if ipSubArr.count > 0 {
                        let ip = ipSubArr[0].trimmingCharacters(in: CharacterSet.whitespaces)
                        currentIP = ip
                        return
                    }
                }
            }else {
                NSLog("获得公网IP URL 转换失败")
            }
        }
        queue.addOperation(blockOP)
    }
}
