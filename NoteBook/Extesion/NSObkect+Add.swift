//
//  NSObkect+Add.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import Foundation

extension NSObject {
    class func className() -> String {
        return String(describing: self)
    }
}
