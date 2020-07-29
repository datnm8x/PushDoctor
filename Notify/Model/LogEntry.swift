//
//  Log Entry.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import Foundation

struct LogEntry: Hashable, Identifiable {
    
    // MARK: Properties
    var id: Push { push }
    
    let date: Date = Date()
    let push: Push
    var errorDescription: String?
    
    // MARK: Initializers
    init(push: Push, errorDescription: String? = nil) {
        self.push = push
        self.errorDescription = errorDescription
    }
}
