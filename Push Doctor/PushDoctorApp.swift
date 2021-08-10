//
//  PushDoctorApp.swift
//  Push Doctor
//
//  Created by Will McGinty on 8/9/21.
//

import SwiftUI

@main
struct PushDoctorApp: App {
    
    @StateObject var store = PushStore()
    var client = PushClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView(client: client, store: store)
        }
    }
}

