//
//  Constrained.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper
struct Constrained<Value: Comparable> {

    private var range: ClosedRange<Value>
    private var value: Value

    init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
        self.value = value
        self.range = range
    }

    var wrappedValue: Value {
        get {
            return max(min(value, range.upperBound), range.lowerBound)
        }
        set {
            value = newValue
        }
    }
}
