//
//  NT_MaintainView.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
class NT_MaintainView:UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.hexWithAlpha(hexString: "#000000", alpha: 0.5)
    }

    class func show() {
        let maintainView = NT_MaintainView.xibView()
        maintainView.frame = UIScreen.main.bounds
        kAppdelegate?.window?.addSubview(maintainView)
    }
}


