//
//  PayloadEditorView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

private var client = PushClient()

struct PayloadEditorView: View {
    
    // MARK: Properties
    @Binding var jsonInput: String
    @State private var isValid: Bool = true
    
    var body: some View {
        VStack {
            TextEditor(text: $jsonInput)
                .border(isValid ? Color.green : Color.red)
                .disableAutocorrection(true)
            HStack {
                Spacer()
                Button("Import", action: importJSON)
                Button("Lint", action: lint)
            }
        }
    }
    
    func importJSON() {
        NSOpenPanel.open(from: ["json"]) { (result: Result<String, NSOpenPanel.OpenError>) in
            switch result {
            case .failure(let error): debugPrint("Error: \(error)")
            case .success(let string):
                self.jsonInput = string
                self.lint()
            }
        }
    }
    
    func lint() {
        guard let data = jsonInput.data(using: .utf8), let prettyPrinted = data.prettyPrintedJSON else {
            isValid = false
            return
        }
        
        isValid = true
        jsonInput = prettyPrinted
    }
}
