// ºººº----------------------------------------------------------------------ºººº \\
//
// Copyright (c) 2022 Hamad Fuad.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Author: Hamad Fuad
// Email: ihamadfouad@icloud.com
//
// Created At: 18/04/2022
// Last modified: 18/04/2022
//
// ºººº----------------------------------------------------------------------ºººº \\

import Foundation

@propertyWrapper public final class Flag<Value> {

    public var wrappedValue: Value
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
