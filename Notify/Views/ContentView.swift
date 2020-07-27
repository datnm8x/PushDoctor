//
//  ContentView.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import SwiftUI
import AppKit

struct ContentView: View {
    
    @ObservedObject var store: PushStore
    var client: PushClient
    
    @State private var isPresentingAddKeySheet: Bool = false
    @State private var isPresentingLogSheet: Bool = false
    
    @State private var selectedKey: AuthorizationKey?
    @State private var bundleID: String = ""
    @State private var deviceToken: String = ""
    @State private var payload: String = String.basicTemplateJSON ?? ""
    @State private var selectedEnvironment: Push.Environment = .sandbox
    @State private var result: String = ""
    
    var body: some View {
        VStack {
            HStack {
                AuthorizationKeyPicker(keys: $store.authorizationKeys, selected: $selectedKey)
                Button("Add New") {
                    isPresentingAddKeySheet.toggle()
                }.sheet(isPresented: $isPresentingAddKeySheet, content: {
                    AddAuthorizationView(store: store)
                })
            }
            
            HStack {
                Text("Bundle ID")
                TextField("com.example.app", text: $bundleID)
            }
            
            HStack {
                Text("Device Token")
                TextField("usually a hex string", text: $deviceToken)
            }
            
            EnvironmentPicker(selected: $selectedEnvironment)
            PayloadEditorView(jsonInput: $payload)
            
            Spacer(minLength: 50)
            
            HStack {
                Spacer()
                Text(result)
                Button("Send", action: send)
                    .disabled(selectedKey == nil || bundleID.isEmpty || deviceToken.isEmpty)
                    .keyboardShortcut(.init(.return))
                Button("Log") {
                    isPresentingLogSheet.toggle()
                }.sheet(isPresented: $isPresentingLogSheet, content: {
                    LogView(store: store)
                })
            }
        }.padding(20)
    }
    
    func send() {
        guard let authorizationKey = selectedKey else { return }
        let push = Push(authorizationKey: authorizationKey, bundleID: bundleID, deviceToken: deviceToken, environment: selectedEnvironment, payload: payload)
        
        client.send(push: push).whenComplete { result in
            
            switch result {
            case .success:
                self.result = "Success"
                store.log(.init(push: push, errorDescription: nil))
            case .failure(let error):
                self.result = "Error: \(error)"
                store.log(.init(push: push, errorDescription: "some error"))
            }
        }
    }
}
