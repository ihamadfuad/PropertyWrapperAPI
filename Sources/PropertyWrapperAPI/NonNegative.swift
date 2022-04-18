//
//  NonNegative.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper struct NonNegative<T: Numeric & Comparable> {

    var value: T

    var wrappedValue: T {
        get { value }

        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }

    init(wrappedValue: T) {
        if wrappedValue < 0 {
            self.value = 0
        } else {
            self.value = wrappedValue
        }
    }
}
