//
//  AuthorizationKeyPicker.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

struct AuthorizationKeyPicker: View {
    
    @Binding var keys: [AuthorizationKey]
    @Binding var selected: AuthorizationKey?

    var body: some View {
        Picker("Select Authorization Key", selection: $selected) {
            Text("None").tag(nil as AuthorizationKey?)
            ForEach(keys) { key in
                Text("\(key.name) - \(key.keyID)").tag(key as AuthorizationKey?)
            }
        }
    }
}
