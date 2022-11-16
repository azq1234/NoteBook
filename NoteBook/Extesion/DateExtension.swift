//
//  DateExtension.swift
//  NoteBook
//
//  Created by admin on 2022/11/16.
//

import Foundation

extension Date {
    
    /// 时间戳日期按照给定的格式转化为日期字符串
    /// - Parameters:
    ///   - format: Date().string(withFormat: "dd/MM/yyyy")  | Date().string(withFormat: "HH:mm")   |  Date().string(withFormat: "dd/MM/yyyy HH:mm")
    ///   - timestamp:
    /// - Returns:"1/12/17"  |  "23:50" |  "1/12/17 23:50"
    static func string(format: String = "yyyy-MM-dd HH:mm:ss", timestamp:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

//        dateFormatter.timeZone = TimeZone(identifier:"Asia/Chongqing")

        return dateFormatter.date(from: timestamp)
    }
    
    
    /// Date日期按照给定的格式转化为日期字符串
    /// - Parameter format: Date format (default is "yyyy-MM-dd").
    /// - Returns: date string.
    static func stringDate(withFormat format: String = "yyyy-MM-dd" , date:Date = Date(),isChina:Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
       if isChina {
            dateFormatter.timeZone = TimeZone(identifier:"Asia/Chongqing")
        }
        return dateFormatter.string(from: date)
    }
}
