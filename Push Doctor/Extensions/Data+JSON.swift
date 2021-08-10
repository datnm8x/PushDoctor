//
//  Data+JSON.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import Foundation

extension Data {
    var prettyPrintedJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }

        return prettyPrintedString
    }
}

extension String {
    
    static var basicTemplateJSON: String? {
        return Bundle.main.url(forResource: "BasicTemplate", withExtension: "json").flatMap {
            return try? String(contentsOf: $0, encoding: .utf8)
        }
    }
    
    static var customKeyTemplateJSON: String? {
        return Bundle.main.url(forResource: "CustomKeyTemplate", withExtension: "json").flatMap {
            return try? String(contentsOf: $0, encoding: .utf8)
        }
    }
    
}
