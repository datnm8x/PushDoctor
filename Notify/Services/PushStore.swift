//
//  PayloadStore.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation

class PushStore: ObservableObject {
    
    @Published var authorizationKeys: [AuthorizationKey]

    // MARK: Initializers
    init() {
        self.authorizationKeys = []
    }

//    // MARK: Modifying
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
//private extension DomainStore {
//
//    static var storageURL: URL {
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        return documentsDirectory.appendingPathComponent("linkedDomains").appendingPathExtension("json")
//    }
//
//    static var storedLinkedDomains: [LinkedDomain] = {
//        guard let data = try? Data(contentsOf: storageURL) else { return [] }
//        let linkedDomains = try! JSONDecoder().decode([LinkedDomain].self, from: data)
//        return linkedDomains
//    }()
//
//    static func updateStoredLinkedDomains(_ domains: [LinkedDomain]) {
//        let data = try! JSONEncoder().encode(domains)
//        try? data.write(to: storageURL)
//    }
//}
