//
//  PayloadEditorView.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import SwiftUI

struct PayloadEditorView: View {
    
    // MARK: Properties
    @Binding var jsonInput: String
    @State private var isPresentingTemplatesSheet: Bool = false
    @State private var isValid: Bool = true
    
    var body: some View {
        VStack {
            TextEditor(text: $jsonInput)
                .border(isValid ? Color.green : Color.red)
                .animation(.default)
                .disableAutocorrection(true)
                .font(Font.body.monospacedDigit())
            
            HStack {
                Button(action: selectTemplate) {
                    Label("Templates", systemImage: "folder.fill")
                }.sheet(isPresented: $isPresentingTemplatesSheet) {
                    TemplateListView(initialJSON: $jsonInput.wrappedValue, selectedTemplate: $jsonInput)
                }
                
                Button(action: importJSON) {
                    Label("Import", systemImage: "square.and.arrow.down.fill")
                }
                Spacer()
                Button(action: lintJSON) {
                    Label("Lint", systemImage: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                }
            }
        }
    }
}

// MARK: Helper
private extension PayloadEditorView {
    
    func selectTemplate() {
        isPresentingTemplatesSheet.toggle()
    }
    
    func importJSON() {
        NSOpenPanel.open(from: ["json"]) { (result: Result<String, NSOpenPanel.OpenError>) in
            switch result {
            case .failure(let error): debugPrint("Error: \(error)")
            case .success(let string):
                self.jsonInput = string
                self.lintJSON()
            }
        }
    }
    
    func lintJSON() {
        withAnimation {
            let processedInput = jsonInput.replacingOccurrences(of: "“", with: "\"").replacingOccurrences(of: "”", with: "\"")
            guard let data = processedInput.data(using: .utf8), let prettyPrinted = data.prettyPrintedJSON else {
                isValid = false; return
            }
            
            isValid = true
            jsonInput = prettyPrinted
        }
    }
}
