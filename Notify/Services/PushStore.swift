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
    
    @Published var activityLog: [LogEntry]

    // MARK: Initializers
    init() {
        self.authorizationKeys = PushStore.storedAuthorizationKeys
        self.activityLog = []
    }

    // MARK: Modifying
    func add(authorizationKey: AuthorizationKey) {
        authorizationKeys.append(authorizationKey)
    }
    
    func log(_ logEntry: LogEntry) {
        activityLog.append(logEntry)
    }
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
