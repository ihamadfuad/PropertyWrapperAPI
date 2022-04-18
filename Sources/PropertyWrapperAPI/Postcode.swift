//
//  Postcode.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper struct Postcode {

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }

    var projectedValue: String? = nil

    var wrappedValue: String {
        didSet {
            projectedValue = validate(wrappedValue) ? nil : wrappedValue
            wrappedValue = validate(wrappedValue) ? wrappedValue : "Invalid Postcode"
        }
    }

    private func validate (_ postcode: String) -> Bool {
        let validFormat = "[A-Z0-9]{1,5}+[ ]{1}+[A-Z0-9]{1,3}"
        let namePred = NSPredicate(format: "SELF MATCHES %@", validFormat)
        return namePred.evaluate(with: postcode)
    }
}
