//
//  AuthorizationKeySelectionView.swift
//  Notify
//
//  Created by William McGinty on 7/28/20.
//

import SwiftUI

struct AuthorizationKeySelectionView: View {
    
    // MARK: Properties
    @ObservedObject var store: PushStore
    @State private var isPresentingAddKeySheet: Bool = false
    @Binding var selectedKey: AuthorizationKey?
    
    var body: some View {
        HStack {
            AuthorizationKeyPicker(keys: $store.authorizationKeys, selected: $selectedKey)
            Button("Add New", action: toggleAddKeySheet)
                .sheet(isPresented: $isPresentingAddKeySheet) {
                    AddAuthorizationKeyView(store: store, addedKey: $selectedKey)
                }
        }
    }
}

// MARK: Helper
private extension AuthorizationKeySelectionView {
    
    func toggleAddKeySheet() {
        isPresentingAddKeySheet.toggle()
    }
}
