//
//  Appending.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

protocol Appendable {

    func appending(string: String) -> Self
}

extension String: Appendable {

    func appending(string: String) -> String {
        return self + string
    }
}

@propertyWrapper
struct Appending<T: Appendable> {

    private(set) var value: T
    let toAppend: String

    var wrappedValue: T {
        get { value }
        set { value = newValue.appending(string: toAppend) }
    }

    init(wrappedValue: T, _ toAppend: String) {
        self.value = wrappedValue
        self.toAppend = toAppend
    }
}

extension Appending: Appendable {

    func appending(string: String) -> Appending<T> {
        return Appending(
            wrappedValue: self.wrappedValue.appending(
                string: string
            ),
            self.toAppend
        )
    }
}
