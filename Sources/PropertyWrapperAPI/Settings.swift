//
//  Settings.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import SwiftUI

class SettingKeys: ObservableObject {
    @AppStorage("onboardingCompleted") var onboardingCompleted = false
    @AppStorage("promptedForProVersion") var promptedForProVersion = false
}

@propertyWrapper
struct Setting<T>: DynamicProperty {

    @StateObject private var keys = SettingKeys()

    private let key: ReferenceWritableKeyPath<SettingKeys, T>

    var wrappedValue: T {
        get {
            keys[keyPath: key]
        }

        nonmutating set {
            keys[keyPath: key] = newValue
        }
    }

    init(_ key: ReferenceWritableKeyPath<SettingKeys, T>) {
        self.key = key
    }
}
