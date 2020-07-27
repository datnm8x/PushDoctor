//
//  TemplateListView.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import SwiftUI

struct TemplateListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var templates: [Template] = [.basic, .customKey]
    @Binding var selectedTemplate: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(templates, id: \.self) { template in
                    Text(template.name)
                        .onTapGesture {
                            selectedTemplate = template.contents
                        }
                }
            }.listStyle(SidebarListStyle())
            VStack {
                ScrollView {
                    Text(selectedTemplate)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                }
                HStack {
                    Spacer()
                    Button("Cancel", action: cancel)
                        .keyboardShortcut(.cancelAction)
                    Button("Choose", action: choose)
                        .keyboardShortcut(.defaultAction)
                }
            }.padding()
        }
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func choose() {
        presentationMode.wrappedValue.dismiss()
    }
}
