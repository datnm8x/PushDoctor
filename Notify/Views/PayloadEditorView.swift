//
//  PayloadEditorView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

private var client = PushClient()

struct PayloadEditorView: View {
    
    @State private var isPresentingTemplatesSheet: Bool = false
    
    
    // MARK: Properties
    @Binding var jsonInput: String
    @State private var isValid: Bool = true
    
    var body: some View {
        VStack {
            TextEditor(text: $jsonInput)
                .border(isValid ? Color.green : Color.red)
                .disableAutocorrection(true)
                .font(Font.body.monospacedDigit())
                
            HStack {
                Button("Templates") {
                    isPresentingTemplatesSheet.toggle()
                }.sheet(isPresented: $isPresentingTemplatesSheet, content: {
                    TemplateListView(selectedTemplate: $jsonInput)
                })
                
                Button("Import", action: importJSON)
                Spacer()
                Button("Lint", action: lint)
            }
        }
    }
    
    func chooseJSONTemplate() {
        print("NYI")
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
        let processedInput = jsonInput.replacingOccurrences(of: "“", with: "\"").replacingOccurrences(of: "”", with: "\"")
        guard let data = processedInput.data(using: .utf8), let prettyPrinted = data.prettyPrintedJSON else {
            isValid = false
            return
        }
        
        isValid = true
        jsonInput = prettyPrinted
    }
}
