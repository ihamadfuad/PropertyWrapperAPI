//
//  SampleFile.swift
//  
//
//  Created by Hamad Ali on 18/04/2022.
//

import Foundation

@propertyWrapper
struct SampleFile {

    let fileName: String

    var wrappedValue: URL {

        let file = fileName.split(separator: ".").first!
        let fileExtension = fileName.split(separator: ".").last!
        let url = Bundle.main.url(forResource: String(file), withExtension: String(fileExtension))!

        return url
    }

    var projectedValue: String {
        return fileName
    }
}
