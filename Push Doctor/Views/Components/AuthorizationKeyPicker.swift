//
//  AuthorizationKeyPicker.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

struct AuthorizationKeyPicker: View {
    
    // MARK: - Properties
    @Binding var keys: [AuthorizationKey]
    @Binding var selected: AuthorizationKey?

    // MARK: - Body
    var body: some View {
        Picker("Select Authorization Key", selection: $selected) {
            Text("None").tag(nil as AuthorizationKey?)
            ForEach(keys) { key in
                Text("[\(key.name)] \(key.keyID) / \(key.teamID)").tag(key as AuthorizationKey?)
            }
        }
    }
}
