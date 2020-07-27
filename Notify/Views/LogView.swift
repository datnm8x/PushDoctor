//
//  LogView.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import SwiftUI

struct LogView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var store: PushStore
    
    var body: some View {
        VStack {
            if store.activityLog.isEmpty {
                Text("No activity yet")
            } else {
                List {
                    ForEach(store.activityLog, id: \.date) { entry in
                        HStack {
                            Image(systemName: entry.errorDescription == nil ? "checkmark.circle" : "exclamationmark.circle")
                            Text(entry.date, formatter: DateFormatter())
                            Text(entry.push.deviceToken)
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                Button("Close", action: close)
            }
        }.padding()
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}
