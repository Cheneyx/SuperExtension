//
//  NSDecimalNumber+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

extension NSDecimalNumber {
    ///两个数计算结果
    ///
    ///    /// 两个数计算结果
    /// - Parameters:
    ///   - fisrt: 被操作数
    ///   - second: 操作数
    ///   - pointCount: 保留的小数位
    ///   - type: 操作符
    /// - Returns: NSDecimalNumber
    public static func calculateBy(_ fisrt: Double , _ second: Double ,_ pointCount: Int16 , _ type: OperatorType) -> NSDecimalNumber{
        let f_num = NSDecimalNumber(value: fisrt)
        let s_num = NSDecimalNumber(value: second)
        let handle = NSDecimalNumberHandler(roundingMode: .plain, scale: pointCount, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        return type.result(f_num, s_num, handle)
    }
}

public enum OperatorType {
    /// +
    case Add
    /// -
    case Sub
    /// *
    case Mul
    /// /
    case Div
}

extension OperatorType {
    public func result(_ f: NSDecimalNumber, _ s: NSDecimalNumber, _ hanle: NSDecimalNumberHandler) -> NSDecimalNumber{
        switch self {
        case .Add:
            return f.adding(s, withBehavior: hanle)
        case .Sub:
            return f.subtracting(s, withBehavior: hanle)
        case .Mul:
            return f.multiplying(by: s, withBehavior: hanle)
        case .Div:
            return f.dividing(by: s, withBehavior: hanle)
        }
    }
}

