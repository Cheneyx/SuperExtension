//
//  NSObject+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

// MARK: - 获取类的字符串名称
extension NSObject {
    /// 对象获取类的字符串名称
    public var className: String {
        return runtimeType.className
    }
    
    /// 类获取类的字符串名称
    public static var className: String {
        return String(describing: self)
    }
    
    /// NSObject对象获取类型
    public var runtimeType: NSObject.Type {
        return type(of: self)
    }
}
