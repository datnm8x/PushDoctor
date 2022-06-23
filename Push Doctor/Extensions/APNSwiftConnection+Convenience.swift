//
//  APNSwiftConnection+Convenience.swift
//  Notify
//
//  Created by William McGinty on 7/26/20.
//

import Foundation
import APNSwift
import NIO

extension APNSwiftConnection {
  
  struct CustomPayload {
    let payload: Data
    let expiration: Date?
    let priority: Int?
    let collapseIdentifier: String?
    let topic: String?
    
    init(payload: Data, expiration: Date? = nil, priority: Int? = nil, collapseIdentifier: String? = nil, topic: String? = nil) {
      self.payload = payload
      self.expiration = expiration
      self.priority = priority
      self.collapseIdentifier = collapseIdentifier
      self.topic = topic
    }
  }
  
  enum PushPayload {
    case standard(APNSwiftPayload)
    case custom(CustomPayload)
  }
  
  func send(pushPayload: PushPayload, to deviceToken: String) -> EventLoopFuture<Void> {
    switch pushPayload {
      case .standard(let payload): return send(payload, to: deviceToken)
      case .custom(let custom):
        return send(raw: custom.payload, to: deviceToken, expiration: custom.expiration, priority: custom.priority,
                    collapseIdentifier: custom.collapseIdentifier, topic: custom.topic)
    }
  }
}


