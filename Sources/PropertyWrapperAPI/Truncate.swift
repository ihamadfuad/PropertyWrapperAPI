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

@propertyWrapper
public struct Truncate {

    private var _value: String = ""
    private let maximumLength: Int

    public var wrappedValue: String {
        set {
            _value = truncate(string: newValue)
        }

        get {
            return _value
        }
    }

    public init(wrappedValue: String, maximumLength: Int = 10) {
        self.maximumLength = maximumLength
        _value = truncate(string: wrappedValue)
    }

    private func truncate(string: String) -> String {

        if string.count > maximumLength {
            return string.prefix(maximumLength) + "..."
        } else {
            return string
        }
    }
}
