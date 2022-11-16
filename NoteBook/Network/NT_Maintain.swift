//
//  NT_Maintain.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation

class NT_Maintain:NSObject{
    
    class func startMaintain(){
        let isContains = kAppdelegate?.window?.subviews.contains(where: { (subview) -> Bool in
            if subview.isMember(of: NT_MaintainView.self) {
                return true
            } else {
                return false
            }
        })
        if isContains! == false {
            NT_MaintainView.show()
        }
    }
}
