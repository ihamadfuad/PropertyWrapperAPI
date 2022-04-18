//
//  Truncate.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper
struct Truncate {

    private var _value: String = ""
    private let maximumLength: Int

    var wrappedValue: String {
        set {
            _value = truncate(string: newValue)
        }

        get {
            return _value
        }
    }

    init(wrappedValue: String, maximumLength: Int = 10) {
        self.maximumLength = maximumLength
        _value = truncate(string: wrappedValue)
    }

    private func truncate(string: String) -> String {

        if string.count > maximumLength {
            return string.prefix(maximumLength) + "..."
        } else {
            return string
        }
    }
}
