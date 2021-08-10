//
//  LabeledInputView.swift
//  Notify
//
//  Created by William McGinty on 7/28/20.
//

import SwiftUI

struct LabeledInputView: View {
    
    // MARK: Properties
    let title: String
    let placeholder: String?
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title)
            TextField(placeholder ?? "", text: $value)
        }
    }
}
