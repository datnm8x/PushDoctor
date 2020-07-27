//
//  EnvironmentPicker.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

struct EnvironmentPicker: View {
    
    @Binding var selected: Push.Environment

    var body: some View {
        Picker("Select Environment", selection: $selected) {
            ForEach(Push.Environment.allCases) { env in
                Text(env.rawValue.capitalized).tag(env as Push.Environment)
            }
        }
    }
}
