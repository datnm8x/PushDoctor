//
//  NSOpenPane+Convenience.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import AppKit

// MARK: - FileOpenable
protocol FileOpenable {
    init?(url: URL)
}

extension String: FileOpenable {
    init?(url: URL) { try? self.init(contentsOf: url) }
}


// MARK: NSOpenPanel + Convenience
extension NSOpenPanel {
    
    enum OpenError: Error {
        case failedToOpen
    }
    
    static func open<T: FileOpenable>(from fileTypes: [String], completion: @escaping (_ result: Result<T, OpenError>) -> ()) {
        let panel = NSOpenPanel()
        
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedFileTypes = fileTypes
        
        panel.begin { result in
            guard result == .OK, let url = panel.urls.first, let contents = T(url: url) else {
                return completion(.failure(.failedToOpen))
            }
            completion(.success(contents))
          
        }
    }
}
