//
//  NT_NetWorkResult.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
class NT_NetWorkResult:NSObject {
    
    //状态码
    var statusCode:Int?
    
    var storeData:[String:Any]?
    
    //数据类型 1
    var data:[String:Any]?{
        get{
            if self.statusCode == 200 {
                return self.storeData?["data"] as? [String : Any]
            }else{
                return nil
            }
        }
    }
    //数据类型 2
    var items:[[String:Any]]?{
        get{
            if self.statusCode == 200 {
                return self.storeData?["items"] as? [[String:Any]]
            }else{
                return nil
            }
        }
    }
    
    //数据类型 3
    var message:String?{
        get{
            return self.storeData?["msg"] as? String
        }
    }
}
