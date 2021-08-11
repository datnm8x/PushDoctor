//
//  AuthorizationKeySelectionView.swift
//  Notify
//
//  Created by William McGinty on 7/28/20.
//

import SwiftUI

struct AuthorizationKeySelectionView: View {
    
    // MARK: - Properties
    @ObservedObject var store: PushStore
    @State private var isPresentingAddKeySheet: Bool = false
    @Binding var selectedKey: AuthorizationKey?
    
    // MARK: - Body
    var body: some View {
        HStack {
            AuthorizationKeyPicker(keys: $store.authorizationKeys, selected: $selectedKey)
            Button(action: removeSelectedKey) {
                Label("Delete", systemImage: "trash.fill")
            }
            .disabled(selectedKey == nil)

            Button(action: toggleAddKeySheet) {
                Label("Add New", systemImage: "plus.circle.fill")
            }
            .sheet(isPresented: $isPresentingAddKeySheet) {
                AddAuthorizationKeyView(store: store, addedKey: $selectedKey)
            }
        }
    }
}

// MARK: - Helper
private extension AuthorizationKeySelectionView {

    func removeSelectedKey() {
        guard let key = selectedKey else { return }

        selectedKey = nil
        store.remove(authorizationKey: key)
    }
    
    func toggleAddKeySheet() {
        isPresentingAddKeySheet.toggle()
    }
}
