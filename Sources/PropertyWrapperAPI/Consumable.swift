//
//  Consumable.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

/// Creates a value that can only be accessed once.
/// Accessing the value will consume and clear the value.
@propertyWrapper
enum Consumable<Value> {
    
    case unused(Value?)
    case used

    init(wrappedValue: Value?) {
        self = .unused(wrappedValue)
    }

    var wrappedValue: Value? {
        mutating get {
            switch self {
            case .unused(let value):
                self = .used
                return value
            case .used:
                return .none
            }
        }
        set {
            self = .unused(newValue)
        }
    }
}
