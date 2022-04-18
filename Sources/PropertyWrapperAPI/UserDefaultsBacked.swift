// ºººº----------------------------------------------------------------------ºººº \\
//
// Copyright (c) 2022 Hamad Fuad.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Author: Hamad Fuad
// Email: ihamadfouad@icloud.com
//
// Created At: 18/04/2022
// Last modified: 18/04/2022
//
// ºººº----------------------------------------------------------------------ºººº \\

import Foundation

public extension UserDefaults {

    static var shared: UserDefaults {

        let combined = UserDefaults.standard
        combined.addSuite(named: "group.default.app")

        return combined
    }
}

public extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {

    init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

@propertyWrapper public struct UserDefaultsBacked<Value> {

    public var wrappedValue: Value {

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

    public init(wrappedValue defaultValue: Value,
         key: String,
         storage: UserDefaults = .standard) {

        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
