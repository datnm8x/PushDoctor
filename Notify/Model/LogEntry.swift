//
//  Log Entry.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import Foundation

struct LogEntry: Hashable, Identifiable {
    
    var id: Push { push }
    
    let date: Date = Date()
    let push: Push
    
    var errorDescription: String?
}
