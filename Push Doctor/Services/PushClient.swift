//
//  PushClient.swift
//  Notify
//
//  Created by William McGinty on 7/24/20.
//

import Foundation
import APNSwift
import NIO
import JWTKit

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
            let authenticationMethod = APNSwiftConfiguration.AuthenticationMethod.jwt(key: try .private(pem: push.authorizationKey.p8.contents),
                                                                                      keyIdentifier: JWKIdentifier(string: push.authorizationKey.keyID),
                                                                                      teamIdentifier: push.authorizationKey.teamID)
            let configuration = APNSwiftConfiguration(authenticationMethod: authenticationMethod, topic: push.bundleID,
                                                      environment: push.environment == .production ? .production : .sandbox, logger: nil, timeout: nil)
            
            return APNSwiftConnection.connect(configuration: configuration, on: eventLoopGroup.next()).flatMap { connection in
                return connection.send(pushPayload: .custom(.init(payload: push.payload.data(using: .utf8)!)), to: push.deviceToken)
            }
            
        } catch {
            return eventLoopGroup.next().makeFailedFuture(error)
        }
    }
}
