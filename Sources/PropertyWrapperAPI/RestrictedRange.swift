//
//  RestrictedRange.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper
struct RestrictedRange<T: Comparable> {

    let validRange: ClosedRange<T>
    let handleNotInRangeValue: (T)->(T)

    var wrappedValue: T {
        didSet {
            adjustWrappedValueToFallWithinRangeIfNeeded()
        }
    }

    init(wrappedValue: T, validRange: ClosedRange<T>, handleNotInRangeValue: @escaping (T)->(T)) {

        self.validRange = validRange
        self.handleNotInRangeValue = handleNotInRangeValue
        self.wrappedValue = wrappedValue

        adjustWrappedValueToFallWithinRangeIfNeeded()
    }

    mutating func adjustWrappedValueToFallWithinRangeIfNeeded() {

        guard validRange.contains(wrappedValue) == false
        else {
            return
        }

        self.wrappedValue = handleNotInRangeValue(wrappedValue)
    }
}
