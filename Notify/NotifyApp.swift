//
//  NotifyApp.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import SwiftUI

@main
struct NotifyApp: App {
    
    @StateObject var store = PushStore()
    var client = PushClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store, client: client)
        }
    }
}
