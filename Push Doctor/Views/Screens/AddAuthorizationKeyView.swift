//
//  AddAuthorizationKeyView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI
import AppKit

struct AddAuthorizationKeyView: View {
  
  // MARK: - Properties
  @ObservedObject var store: PushStore
  
  @Environment(\.presentationMode) private var presentationMode
  @Binding var addedKey: AuthorizationKey?
  @State private var importedKey: AuthorizationKey.P8?
  @State private var name: String = ""
  @State private var keyID: String = ""
  @State private var teamID: String = ""
  
  // MARK: - Body
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Spacer()
        Text("Add Authorization Key")
          .font(.headline)
        Spacer()
      }
      
      ZStack {
        Rectangle()
          .foregroundColor(Color.secondary.opacity(0.1))
          .cornerRadius(8)
        if let importedKey = importedKey {
          VStack {
            Text(importedKey.fileName)
              .onTapGesture { self.importedKey = nil }
            Text(importedKey.sourceURL.absoluteString)
              .font(.caption2)
              .foregroundColor(.secondary)
          }
        } else {
          Button(action: selectAuthorizationKey) {
            Label("Import", systemImage: "plus.circle.fill")
          }
        }
      }
      
      VStack {
        LabeledInputView(title: "Name", placeholder: "My P8 Key", value: $name)
        HStack {
          LabeledInputView(title: "Key ID", placeholder: nil, value: $keyID)
          Spacer()
          LabeledInputView(title: "Team ID", placeholder: nil, value: $teamID)
        }
      }
      
      HStack {
        Spacer()
        
        Button("Cancel", action: cancel)
          .keyboardShortcut(.cancelAction)
        
        Button("Save", action: saveKey)
          .keyboardShortcut(.defaultAction)
          .disabled(importedKey == nil)
      }
    }
    .frame(minWidth: 400, maxWidth: 400, minHeight: 200, maxHeight: 200)
    .padding()
  }
}

// MARK: - Helper
private extension AddAuthorizationKeyView {
  
  func cancel() {
    presentationMode.wrappedValue.dismiss()
  }
  
  func saveKey() {
    presentationMode.wrappedValue.dismiss()
    
    if let importedKey = importedKey {
      let key = AuthorizationKey(p8: importedKey, name: name, keyID: keyID, teamID: teamID)
      store.add(authorizationKey: key)
      addedKey = key
    }
  }
  
  func selectAuthorizationKey() {
    NSOpenPanel.open(from: ["p8"]) { (result: Result<AuthorizationKey.P8, NSOpenPanel.OpenError>) in
      switch result {
        case .failure(let error): debugPrint("Import error: \(error)")
        case .success(let content):
          self.importedKey = content
          self.name = self.name.isEmpty ? content.fileName : self.name
      }
    }
  }
}

