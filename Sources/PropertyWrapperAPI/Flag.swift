//
//  Flag.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper final class Flag<Value> {

    var wrappedValue: Value
    let name: String

    fileprivate init(wrappedValue: Value, name: String) {

        self.wrappedValue = wrappedValue
        self.name = name
    }
}

private struct FlagCodingKey: CodingKey {

    var stringValue: String
    var intValue: Int?

    init(name: String) {
        stringValue = name
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}

private protocol DecodableFlag {

    typealias Container = KeyedDecodingContainer<FlagCodingKey>

    func decodeValue(from container: Container) throws
}

extension Flag: DecodableFlag where Value: Decodable {

    fileprivate func decodeValue(from container: Container) throws {

        let key = FlagCodingKey(name: name)

        // We only want to attempt to decode a value if it's present,
        // to enable our app to fall back to its default value
        // in case the flag is missing from our backend data:
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        }
    }
}
