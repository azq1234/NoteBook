//
//  UImageView+Add.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit
import Kingfisher
extension UIImageView {
    func setImageForImgV(urlStr:String,placeImg: UIImage?){
        let url:URL = URL(string: urlStr) ?? URL(string: "https://www.baidu.com")!
        self.kf.setImage(with: ImageResource(downloadURL: url,cacheKey:urlStr), placeholder: placeImg, options: nil, progressBlock: nil) { (Result) in
            
        }
    }
}
