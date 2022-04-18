//
//  Base64Encoding.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper
struct Base64Encoding {

    private var value = ""

    var wrappedValue: String {
        get { Data(value.utf8).base64EncodedString() }
        set { value = newValue }
    }
}
