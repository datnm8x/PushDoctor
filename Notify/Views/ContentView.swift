//
//  ContentView.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import SwiftUI
import AppKit

struct ContentView: View {
    
    // MARK: Properties
    var client: PushClient
    @ObservedObject var store: PushStore
    
    @State private var selectedKey: AuthorizationKey?
    @State private var bundleID: String = ""
    @State private var deviceToken: String = ""
    @State private var payload: String = String.basicTemplateJSON ?? ""
    @State private var selectedEnvironment: Push.Environment = .sandbox
    @State private var result: String?
    
    @State private var isPresentingLogSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                AuthorizationKeySelectionView(store: store, selectedKey: $selectedKey)
                LabeledInputView(title: "Bundle ID", placeholder: "com.example.app", value: $bundleID)
                LabeledInputView(title: "Device Token", placeholder: "usually 64 hexadecimal characters", value: $deviceToken)
                EnvironmentPicker(selected: $selectedEnvironment)
                PayloadEditorView(jsonInput: $payload)
            }
             
            HStack {
                Spacer()
                
                result.map(Text.init)
                Button(action: toggleLog) {
                    Label("View Log", systemImage: "book.fill")
                }.sheet(isPresented: $isPresentingLogSheet) {
                    LogView(store: store)
                }
                
                Button(action: sendNotification) {
                    Label("Send", systemImage: "cloud.fill")
                }
                .disabled(push == nil)
                .keyboardShortcut(.init(.return))
            }
            
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
    }
}

// MARK: Helper
private extension ContentView {
    
    var push: Push? {
        guard !bundleID.isEmpty && !deviceToken.isEmpty else { return nil }
        return selectedKey.map { Push(authorizationKey: $0, bundleID: bundleID, deviceToken: deviceToken,
                                      environment: selectedEnvironment, payload: payload) }
    }
    
    func sendNotification() {
        guard let push = push else { return }
        client.send(push: push).whenComplete { result in
            
            switch result {
            case .success:
                self.result = "Success"
                self.store.log(LogEntry(push: push))
                
            case .failure(let error):
                self.result = "Failure"
                self.store.log(LogEntry(push: push, errorDescription: error.localizedDescription))
            }
        }
    }
    
    func toggleLog() {
        isPresentingLogSheet.toggle()
    }
}

