//
//  String+Add.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation
extension String {
    /// 判断字符串包含
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
}
