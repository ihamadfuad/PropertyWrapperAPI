//
//  UserDefaultsBacked.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

extension UserDefaults {

    static var shared: UserDefaults {

        let combined = UserDefaults.standard
        combined.addSuite(named: "group.default.app")

        return combined
    }
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {

    init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper struct UserDefaultsBacked<Value> {

    var wrappedValue: Value {

        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {

            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.setValue(newValue, forKey: key)
            }
        }
    }

    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults

    init(wrappedValue defaultValue: Value,
         key: String,
         storage: UserDefaults = .standard) {

        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
