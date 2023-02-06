//
//  Int+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

extension Int {
    var toString: String {
        "\(self)"
    }

    var toBool: Bool {
        self == 0 ? false : true
    }

    var countStr: String {
        if self < 10000 , self >= 0 {
            return self.toString
        } else if self >= 10000 {
            return NSDecimalNumber.calculateBy(Double(self), 10000, 1, .Div).stringValue + "万"
        } else {
            return ""
        }
    }
}
