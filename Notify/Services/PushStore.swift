//
//  PayloadStore.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation

class PushStore: ObservableObject {
    
    @Published var authorizationKeys: [AuthorizationKey] {
        didSet { PushStore.updateStoredAuthorizationKeys(authorizationKeys) }
    }

    // MARK: Initializers
    init() {
        self.authorizationKeys = PushStore.storedAuthorizationKeys
    }

    // MARK: Modifying
    func add(authorizationKey: AuthorizationKey) {
        authorizationKeys.append(authorizationKey)
    }
//
//    func removeDomain(at indexes: IndexSet) {
//        linkedDomains.remove(atOffsets: indexes)
//    }
//
//    func moveDomains(atOffsets offsets: IndexSet, to index: Int) {
//        linkedDomains.move(fromOffsets: offsets, toOffset: index)
//    }
//
//    func updateDomain(for url: URL, with domain: LinkedDomain) {
//        if let firstIndex = linkedDomains.firstIndex(where: { $0.baseURL == url }) {
//            linkedDomains.replaceSubrange(firstIndex...firstIndex, with: [domain])
//        }
//    }
}

//// MARK: Storage
private extension PushStore {

    static var storageURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("authorizationKeys").appendingPathExtension("json")
    }

    static var storedAuthorizationKeys: [AuthorizationKey] = {
        guard let data = try? Data(contentsOf: storageURL) else { return [] }
        let keys = try! JSONDecoder().decode([AuthorizationKey].self, from: data)
        return keys
    }()

    static func updateStoredAuthorizationKeys(_ keys: [AuthorizationKey]) {
        let data = try! JSONEncoder().encode(keys)
        try? data.write(to: storageURL)
    }
}
