//
//  LogEntry+ErrorHandling.swift
//  Notify
//
//  Created by Will McGinty on 8/9/21.
//

import NIOSSL

extension LogEntry {
    
    init(push: Push, error: Error) {
        guard let nioError = error as? NIOSSLError else {
            self.init(push: push, errorDescription: error.localizedDescription); return
        }
            
        self.init(push: push, errorDescription: "[Case: \(nioError.caseDescription)] \(nioError.localizedDescription)",
                  underlyingErrorDescription: nioError.underlyingErrorDescription)
    }
}

// MARK: - NIOSSLError + Formatting
private extension NIOSSLError {
    
    var caseDescription: String {
        switch self {
        case .cannotFindPeerIP: return "cannotFindPeerIP"
        case .cannotMatchULabel: return "cannotMatchULabel"
        case .failedToLoadCertificate: return "failedToLoadCertificate"
        case .failedToLoadPrivateKey: return "failedToLoadPrivateKey"
        case .handshakeFailed: return "handshakeFailed"
        case .noCertificateToValidate: return "noCertificateToValidate"
        case .noSuchFilesystemObject: return "noSuchFilesystemObject"
        case .writeDuringTLSShutdown: return "writeDuringTLSShutdown"
        case .unableToAllocateBoringSSLObject: return "unableToAllocateBoringSSLObject"
        case .shutdownFailed: return "shutdownFailed"
        case .unableToValidateCertificate: return "unableToValidateCertificate"
        case .readInInvalidTLSState: return "readInInvalidTLSState"
        case .uncleanShutdown: return "uncleanShutdown"
        }
    }
    
    var underlyingErrorDescription: String? {
        switch self {
        case .handshakeFailed(let sslError): return sslError.localizedDescription
        case .shutdownFailed(let sslError): return sslError.localizedDescription
        default: return nil
        }
    }
    
}
