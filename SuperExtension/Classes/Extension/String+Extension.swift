//
//  String+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import CommonCrypto

public protocol OptionalString {}
extension String: OptionalString {}

extension Optional where Wrapped: OptionalString {
    /// 让String非Nil，当Nil时返回空字符串
    public var orEmpty: String {
        if self == nil {
            return ""
        } else {
            return self as! String
        }
    }
}

extension String {
    // MD5加密
    public var md5: String {
        let utf8_str = self.cString(using: .utf8)
        let str_len = CC_LONG(self.lengthOfBytes(using: .utf8))
        let digest_len = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digest_len)
        CC_MD5(utf8_str, str_len, result)
        let str = NSMutableString()
        for i in 0 ..< digest_len {
            str.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return str as String
    }
    
    public var toDouble: Double {
        return Double(self) ?? 0.0
    }
    
    public var getArticleTime: String {
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formate.date(from: self) else {
            return self
        }
        
        let year = NSCalendar.current.component(.year, from: date)
        
        let currentDate = Date()
        let current = NSCalendar.current.component(.year, from: currentDate)
        
        if year != current { // 不是同一年
            formate.dateFormat = "yyyy-MM-dd HH:mm"
            return formate.string(from: date)
        } else {
            let interval = currentDate.timeIntervalSince(date)
            if interval < 60 * 60 {
                let time = NSDecimalNumber.calculateBy(interval, 60, 0, .Div).stringValue
                return "\(time)分钟前"
            } else if interval < 60 * 60 * 24 {
                let time = NSDecimalNumber.calculateBy(interval, 60 * 60, 0, .Div).stringValue
                return "\(time)小时前"
            } else {
                formate.dateFormat = "MM-dd HH:mm"
                return formate.string(from: date)
            }
        }
    }
}

// 计算字符串长度
extension String {
    // 根据font 计算字符串长度
    public func size(withFont font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: attributes)
    }
    
    /// 计算字符串size
    public func stringSize(font: UIFont, contarainSize: CGSize) -> CGSize {
        let size_string = (self as NSString).boundingRect(with: contarainSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return size_string
    }
}
