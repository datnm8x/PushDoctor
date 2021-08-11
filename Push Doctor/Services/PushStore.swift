//
//  PayloadStore.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation
import KeychainAccess

class PushStore: ObservableObject {
    
    @Published var authorizationKeys: [AuthorizationKey] {
        didSet { PushStore.updateStoredAuthorizationKeys(authorizationKeys) }
    }
    
    @Published var activityLog: [LogEntry]

    // MARK: - Initializers
    init() {
        self.authorizationKeys = PushStore.storedAuthorizationKeys
        self.activityLog = []
    }

    // MARK: - Modifying
    func add(authorizationKey: AuthorizationKey) {
        authorizationKeys.append(authorizationKey)
    }

    func remove(authorizationKey: AuthorizationKey) {
        authorizationKeys.removeAll(where: { $0.keyID == authorizationKey.keyID })
    }
    
    func log(_ logEntry: LogEntry) {
        activityLog.insert(logEntry, at: 0)
    }
}

// MARK: - Storage
private extension PushStore {

    private static var keychain: Keychain { Keychain(service: "com.mcginty.will.notify") }

    static var storedAuthorizationKeys: [AuthorizationKey] = {
        guard let data = keychain[data: "authorizationKeys"] else { return [] }
        let keys = try! JSONDecoder().decode([AuthorizationKey].self, from: data)
        return keys
    }()

    static func updateStoredAuthorizationKeys(_ keys: [AuthorizationKey]) {
        keychain[data: "authorizationKeys"] = (try? JSONEncoder().encode(keys)) ?? Data()
    }
}
