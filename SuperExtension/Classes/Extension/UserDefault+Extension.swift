//
//  UserDefault+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func saveData(vaule: Any, key: String) {
        let use = UserDefaults.standard
        use.setValue(vaule, forKey: key)
        use.synchronize()
    }
    
    static func objectVaule(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
