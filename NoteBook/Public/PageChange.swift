//
//  PageChange.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import Foundation
import UIKit
class  PageChange:NSObject{
    
    class func goToWeb(webTitle:String="Web Page",
                  webUrl:String="https://www.baidu.com",
                  viewVC:UIViewController){
        let vc = About_NT(url: webUrl)
        vc.hidesBottomBarWhenPushed = true
        viewVC.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    
    
}
