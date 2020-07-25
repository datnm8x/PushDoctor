//
//  AuthorizationKey.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation


struct AuthorizationKey: Codable {
    
    // MARK: Properties
    let sourceURL: URL
    let contents: String
}

// MARK: - FileOpenable
extension AuthorizationKey: FileOpenable {
    
    init?(url: URL) {
        guard let contents = try? String(contentsOf: url) else { return nil }
        self.init(sourceURL: url, contents: contents)
    }
}
