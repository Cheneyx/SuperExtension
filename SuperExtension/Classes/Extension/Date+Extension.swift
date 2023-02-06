//
//  Date+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

public extension Date {
    /// 时间戳（毫秒）
    var timestamp: Int {
        Int(timeIntervalSince1970 * 1000)
    }

    /// 时间戳（毫秒）字符串
    var timestampString: String {
        timestamp.toString
    }

    /// 年份
    var year: Int {
        Calendar.current.component(.year, from: self)
    }

    /// 月份
    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    /// 日
    var day: Int {
        Calendar.current.component(.day, from: self)
    }

    /// 小时
    var hours: Int {
        Calendar.current.component(.hour, from: self)
    }

    /// 分钟
    var mintes: Int {
        Calendar.current.component(.minute, from: self)
    }

    /// 秒
    var seconds: Int {
        Calendar.current.component(.second, from: self)
    }

    /// 年月日
    func YMDStringBy(_ separate: String) -> String {
        year.toString + separate + month.toString + separate + day.toString
    }

    /// 时分秒
    func HMSStringBy(_ showSecond: Bool = false) -> String {
        if showSecond {
            return "\(hours):\(mintes):\(seconds)"
        } else {
            return "\(hours):\(mintes)"
        }
    }

    /// 比较self和 compareTime 那个时间比较早
    func compareTimeIsEarly(_ compareTime: Date) -> Bool {
        compare(compareTime) == .orderedAscending
    }
}
