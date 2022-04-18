//
//  Logged.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation
import OSLog

@propertyWrapper
struct Logged<Value> where Value: CustomStringConvertible {
    private var value: Value

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    var wrappedValue: Value {
        get {

            Logger(subsystem: "SubApp", category: "App").log(level: .debug, "GET: \(value)")

            return value
        }
        set {

            Logger(subsystem: "SubApp", category: "App").log(level: .debug, "SET: \(newValue)")

            value = newValue
        }
    }
}
