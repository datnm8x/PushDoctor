//
//  NotifyApp.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import SwiftUI

@main
struct NotifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(keyID: .constant("keyId"), teamID: .constant("teamID"), bundleID: .constant("bundleID"), token: .constant("deviceToken"), sandbox: .constant(true))
        }
    }
}
