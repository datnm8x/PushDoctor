//
//  PushDoctorApp.swift
//  Push Doctor
//
//  Created by Will McGinty on 8/9/21.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}

@main
struct PushDoctorApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @StateObject var store = PushStore()
  var client = PushClient()
  
  var body: some Scene {
    WindowGroup {
      ContentView(client: client, store: store)
    }
  }
}


