//
//  Codable+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

extension Encodable {
    /// 转二进制
    var toData: Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }
    
    /// 转Any
    var toAny: Any? {
        guard let data = toData else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    }
    
    /// Any转成数组
    func toArray<T>() -> [T]? {
        toAny as? [T]
    }

    /// Any转成字典
    var toDictionary: [String: Any]? {
        toAny as? [String: Any]
    }
}
