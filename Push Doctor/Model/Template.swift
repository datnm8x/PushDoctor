//
//  Template.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import Foundation

struct Template: Codable, Hashable, Identifiable {
    
    var id: String { name }
    
    let name: String
    let contents: String
    
    static let basic = Template(name: "Basic", contents: String.basicTemplateJSON ?? "")
    static let customKey = Template(name: "Custom Key", contents: String.customKeyTemplateJSON ?? "")
}

// MARK: - FileOpenable
extension Template: FileOpenable {
    
    init?(url: URL) {
        guard let contents = try? String(contentsOf: url) else { return nil }
        let name = url.lastPathComponent.replacingOccurrences(of: ".\(url.pathExtension)", with: "")
        self.init(name: name, contents: contents)
    }
}
