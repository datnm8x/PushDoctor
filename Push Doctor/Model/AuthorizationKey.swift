//
//  AuthorizationKey.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation
import SwiftUI

struct AuthorizationKey: Codable, Hashable, Identifiable {
    
    var id: P8 { p8 }
    
    // MARK: - Properties
    let p8: P8
    var name: String
    var keyID: String
    var teamID: String
}

extension AuthorizationKey {
    
    struct P8: Codable, Hashable, Identifiable {
        
        var id: URL { sourceURL }
        
        // MARK: - Properties
        let sourceURL: URL
        let contents: String
        
        var fileName: String {
            return sourceURL.lastPathComponent
        }
    }
}

// MARK: - FileOpenable
extension AuthorizationKey.P8: FileOpenable {
    
    init?(url: URL) {
        guard let contents = try? String(contentsOf: url) else { return nil }
        self.init(sourceURL: url, contents: contents)
    }
}
