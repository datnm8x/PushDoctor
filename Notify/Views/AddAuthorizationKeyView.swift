//
//  AddAuthorizationKeyView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI
import AppKit

struct AddAuthorizationView: View {
    
    // MARK: - Properties
    @ObservedObject var store: PushStore
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var importedKey: AuthorizationKey.P8?
    @State private var name: String = ""
    @State private var keyID: String = ""
    @State private var teamID: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Authorization Key")
                        .font(Font.headline.bold())
                    Button("Import", action: selectAuthorizationKey)
                    Spacer()
                }
                
                if let importedKey = importedKey {
                    Text(importedKey.sourceURL.absoluteString)
                        .font(.caption)
                        .transition(AnyTransition.move(edge: .top))
                }
            }
            
            Spacer(minLength: 20)
            
            HStack {
                Text("Name")
                TextField("name", text: $name)
                Spacer()
            }

            HStack {
                Text("Key ID")
                TextField("key", text: $keyID)
                Spacer()
                Text("Team ID")
                TextField("team", text: $teamID)
            }
            
            HStack {
                Spacer()
                Button("Cancel", action: cancel)
                Button("Save", action: save)
                    .disabled(importedKey == nil)
            }
        }.padding()
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func save() {
        presentationMode.wrappedValue.dismiss()
        
        guard let importedKey = importedKey else { return }
        let key = AuthorizationKey(p8: importedKey, name: name, keyID: keyID, teamID: teamID)
        store.add(authorizationKey: key)
    }
    
    func selectAuthorizationKey() {
        NSOpenPanel.open(from: ["p8"]) { (result: Result<AuthorizationKey.P8, NSOpenPanel.OpenError>) in
            switch result {
            case .failure(let error): print(error)
            case .success(let content): self.importedKey = content
            }
        }
    }
}
