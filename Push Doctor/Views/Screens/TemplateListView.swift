//
//  TemplateListView.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import SwiftUI

struct TemplateListView: View {
  
  // MARK: - Properties
  @Environment(\.presentationMode) private var presentationMode
  
  @ObservedObject var templateStore: TemplateStore
  @State var initialJSON: String
  @Binding var selectedTemplate: String
  
  // MARK: - Body
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
                  renameTemplate(template)
                }
              } label: { Label("Rename", systemImage: "pencil") }
              
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
                    templateStore.templates.append(content)
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
}

// MARK: - Helper
private extension TemplateListView {
  
  func renameTemplate(_ template: Template) {
    NSAlert.presentAlert(for: .templateNaming(with: template.name, acceptAction: { name in
      guard name != template.name else { /* No op */ return }
      guard !templateStore.templates.contains(where: { $0.name == name }) else {
        return NSAlert.presentInformationalAlert(for: .duplicateName)
      }
      
      templateStore.replace(template: template, with: .init(name: name, contents: template.contents))
    }))
  }
  
  func cancel() {
    selectedTemplate = initialJSON
    presentationMode.wrappedValue.dismiss()
  }
  
  func choose() {
    presentationMode.wrappedValue.dismiss()
  }
}

