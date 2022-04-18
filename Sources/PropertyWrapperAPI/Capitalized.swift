//
//  Capitalized.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper struct Capitalized {

    var wrappedValue: String {

        didSet {
            wrappedValue = wrappedValue.capitalized
        }
    }

    init(wrappedValue: String) {

        self.wrappedValue = wrappedValue.capitalized
    }
}
