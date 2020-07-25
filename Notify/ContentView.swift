//
//  ContentView.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import SwiftUI
import AppKit

private var client = PushClient()

struct ContentView: View {
    
    @State var key: AuthorizationKey?
    @Binding var keyID: String
    @Binding var teamID: String
    @Binding var bundleID: String
    @Binding var token: String
    @Binding var sandbox: Bool
    
    var body: some View {
        VStack {
            Button("Select Auth Key") {
                selectAuthorizationKey()
            }
            
            HStack {
                Text("Key ID")
                TextField("key", text: $keyID)
            }
            HStack {
                Text("Team ID")
                TextField("team", text: $teamID)
            }
            
            HStack {
                Text("Bundle ID")
                TextField("bundle", text: $bundleID)
            }
            
            HStack {
                Text("Device Token")
                TextField("token", text: $token)
            }
            
            Toggle("Sandbox?", isOn: $sandbox)
            Button("send") {
                send(with: key!.contents, keyID: keyID, teamID: teamID, bundleID: bundleID, deviceToken: token, sandbox: sandbox)
            }
            .disabled(key == nil)
            
        }.padding()
        
    }
    
    func send(with key: String, keyID: String, teamID: String, bundleID: String, deviceToken: String, sandbox: Bool) {
        client.send(with: key, keyID: keyID, teamID: teamID, bundleID: bundleID, deviceToken: deviceToken, sandbox: sandbox)
    }
    
    func selectAuthorizationKey() {
        NSOpenPanel.open(from: ["p8"]) { (result: Result<AuthorizationKey, NSOpenPanel.OpenError>) in
            switch result {
            case .failure(let error): print(error)
            case .success(let content): self.key = content
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(keyID: .constant("key"), teamID: .constant("team"), bundleID: .constant("bundle"), token: .constant("12344135315"), sandbox: .constant(true))
    }
}

