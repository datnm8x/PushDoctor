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
    
    // MARK: - Properties
    private lazy var eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    // MARK: - Initializer
    init() { }
    
    deinit {
        eventLoopGroup.shutdownGracefully(queue: .global(qos: .userInitiated)) { error in
            if let error = error {
                debugPrint("Error shutting down: \(String(describing: error))")
            }
        }
    }
        
    // MARK: Interface
    func send(push: Push) -> EventLoopFuture<Void> {
        do {
            let signer = try APNSwiftSigner(buffer: ByteBuffer(string: push.authorizationKey.p8.contents))
            let configuration = APNSwiftConfiguration(keyIdentifier: push.authorizationKey.keyID, teamIdentifier: push.authorizationKey.teamID, signer: signer,
                                                      topic: push.bundleID, environment: push.environment == .production ? .production : .sandbox)
            return APNSwiftConnection.connect(configuration: configuration, on: eventLoopGroup.next()).flatMap { connection in
                return connection.send(pushPayload: .custom(.init(payload: push.payload.data(using: .utf8)!)), to: push.deviceToken)
            }
        } catch {
            return eventLoopGroup.next().makeFailedFuture(error)
        }
    }
}
