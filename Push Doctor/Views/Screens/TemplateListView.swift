//
//  TemplateListView.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import SwiftUI

struct TemplateListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var templateStore = TemplateStore()
    @State var initialJSON: String
    @Binding var selectedTemplate: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(templateStore.templates, id: \.self) { template in
                    Text(template.name)
                        .onTapGesture {
                            selectedTemplate = template.contents
                        }
                        .contextMenu {
                            Button {
                                withAnimation {
                                    templateStore.remove(template: template)
                                }
                            } label: { Label("Delete", systemImage: "trash.fill") }
                        }
                }
                Text("Add New")
                    .onTapGesture {
                        NSOpenPanel.open(from: ["json"]) { (result: Result<Template, NSOpenPanel.OpenError>) in
                            switch result {
                            case .failure(let error): debugPrint("Import error: \(error)")
                            case .success(let content):
                                withAnimation {
                                    self.templateStore.templates.append(content)
                                }
                            }
                        }
                    }
            }.listStyle(SidebarListStyle())
                
            VStack {
                Text("Templates")
                    .font(.headline)
                
                ScrollView {
                    Text(selectedTemplate)
                        .font(Font.body.monospacedDigit())
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
        selectedTemplate = initialJSON
        presentationMode.wrappedValue.dismiss()
    }
    
    func choose() {
        presentationMode.wrappedValue.dismiss()
    }
}
