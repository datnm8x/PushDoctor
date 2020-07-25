//
//  PushClient.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import Foundation
import APNSwift
import NIO

class PushClient {
    
    private lazy var eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    init() { }
        
    func send(with key: String, keyID: String, teamID: String, bundleID: String, deviceToken: String, sandbox: Bool) {
        let signer = try! APNSwiftSigner(buffer: ByteBuffer(string: key))
        let configuration = APNSwiftConfiguration(keyIdentifier: keyID, teamIdentifier: teamID, signer: signer, topic: bundleID, environment: sandbox ? .sandbox : .production)
        let connection = try! APNSwiftConnection.connect(configuration: configuration, on: eventLoopGroup.next()).wait()
        
        let payload = APNSwiftPayload(alert: .init(title: "test title", subtitle: "subtitle", body: nil, titleLocKey: nil, titleLocArgs: nil, actionLocKey: nil, locKey: nil, locArgs: nil, launchImage: nil), badge: nil, sound: nil, hasContentAvailable: false, hasMutableContent: false, category: nil, threadID: nil)
  
        let result = connection.send(payload, to: deviceToken)
    }
    
    deinit {
        eventLoopGroup.shutdownGracefully(queue: .global(qos: .userInitiated)) { error in
            debugPrint("error shutting down: \(error)")
        }
    }
    
}
