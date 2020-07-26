//
//  PayloadEditorView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

private var client = PushClient()

struct PayloadEditorView: View {
    
    @Binding var json: String
    @State private var lintsSuccessfully: Bool = true
    
    var body: some View {
        VStack {
            TextEditor(text: $json)
                .border(lintsSuccessfully ? Color.green : Color.red)
                .disableAutocorrection(true)
            HStack {
                Spacer()
                Button("Lint", action: lint)
            }
        }
    }
    
    func lint() {
        guard let _ = try? JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) else {
            lintsSuccessfully = false; return
        }
        
        lintsSuccessfully = true
    }
}
