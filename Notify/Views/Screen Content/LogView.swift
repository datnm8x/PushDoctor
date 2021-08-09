//
//  LogView.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import SwiftUI

struct LogView: View {
    
    // MARK: Properties
    @ObservedObject var store: PushStore
    @State private var selectedEntries: Set<LogEntry> = []
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Activity Log")
                .font(.headline)
            
            if store.activityLog.isEmpty {
                Spacer()
                EmptyLogView()
                    .foregroundColor(Color.secondary)
                
            } else {
                List {
                    ForEach(store.activityLog, id: \.date) { entry in
                        LogEntryView(entry: entry, isExpanded: selectedEntries.contains(entry))
                            .onTapGesture { handleSelection(of: entry) }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Close", action: closeLog)
                    .keyboardShortcut(.defaultAction)
            }
        }
        .frame(minWidth: 550, maxWidth: 550, minHeight: 300, maxHeight: 500)
        .padding()
    }
}

// MARK: Helper
private extension LogView {
    
    func closeLog() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func handleSelection(of entry: LogEntry) {
        if selectedEntries.contains(entry) {
            selectedEntries.remove(entry)
        } else {
            selectedEntries.insert(entry)
        }
    }
}

// MARK: Subviews
struct EmptyLogView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "books.vertical.fill")
            Text("No activity yet")
                .font(.caption)
        }
    }
}

struct LogEntryView: View {
    
    // MARK: Properties
    let entry: LogEntry
    let isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: entry.errorDescription == nil ? "checkmark.circle" : "exclamationmark.circle")
                    .foregroundColor(entry.errorDescription == nil ? Color.green : Color.red)
                Text(entry.push.bundleID)
                Spacer()
                Text(entry.date, formatter: DateFormatter.standard)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if isExpanded {
                VStack(alignment: .leading) {
                    if let error = entry.completeErrorDescription {
                        LogEntryDetailAttributeView(title: "Error", value: error)
                    }
                    
                    LogEntryDetailAttributeView(title: "Device Token", value: entry.push.deviceToken)
                    LogEntryDetailAttributeView(title: "Environment", value: entry.push.environment.rawValue.capitalized)
                    Spacer()
                    Text(entry.push.payload)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(Font.caption.monospacedDigit())
                        .lineLimit(nil)
                    
                }
                .padding([.bottom])
            }
        }
        .contentShape(Rectangle())
    }
}

struct LogEntryDetailAttributeView: View {
    
    // MARK: Properties
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(title)
                .foregroundColor(.secondary)
                .font(.caption2)
            Text(value)
                .font(.caption)
        }
    }
}
