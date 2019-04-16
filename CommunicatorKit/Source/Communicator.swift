//
//  Communicator.swift
//  FeedingKit
//
//  Created by Jason Ji on 4/10/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#endif
import os.log
import WatchConnectivity

open class Communicator: NSObject {
    @objc public var wcSession: WCSession = WCSession.default
    public let messageHandler: MessageHandler
    public weak var errorDelegate: CommunicatorErrorDelegate?
    
    public init(messageHandler: MessageHandler, errorDelegate: CommunicatorErrorDelegate? = nil) {
        self.messageHandler = messageHandler
        self.errorDelegate = errorDelegate
        super.init()
        
        wcSession.delegate = self
        wcSession.activate()
    }
    
    open func validateWatchConnectivity() -> ValidationResult {
        guard WCSession.isSupported() else { return .error(TransferError.transferNotSupported) }
        guard wcSession.activationState == .activated else { return .error(TransferError.sessionNotActive) }
        #if os(iOS)
        guard wcSession.isPaired else { return .error(TransferError.notPaired) }
        guard wcSession.isWatchAppInstalled else { return .error(TransferError.appNotInstalled) }
        #endif
        
        return .success
    }
    
    open func sendMessage(_ transferMessage: TransferMessage, withSuccess success: @escaping WatchCommunicationSuccessHandler, withFailure failure: @escaping WatchCommunicationFailureHandler<TransferError>) {
        if case let .error(transferError) = validateWatchConnectivity() {
            failure(transferError)
            return
        }
        
        // If the message requires synchronous, and live messaging is not available, an error is thrown.
        if transferMessage.synchronous {
            guard wcSession.isReachable else {
                failure(TransferError.notReachable)
                return
            }
            wcSession.sendMessage(transferMessage.userInfo, replyHandler: { (replyInfo) in
                success(replyInfo)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        else {
            // Send the message as:
            // 1. a complication update, if available (iOS only)
            // 2. a live message, if available
            // 3. in the background, otherwise.
            #if os(iOS)
            if wcSession.remainingComplicationUserInfoTransfers > 0 {
                sendMessageAsComplicationUpdate(transferMessage, withSuccess: success, withFailure: failure)
            }
            else if wcSession.isReachable {
                sendMessageAsLive(transferMessage, withSuccess: success, withFailure: failure)
            }
            else {
                sendMessageAsUserInfoTransfer(transferMessage, withSuccess: success, withFailure: failure)
            }
            #else
            if wcSession.isReachable {
                sendMessageAsLive(transferMessage, withSuccess: success, withFailure: failure)
            }
            else {
                sendMessageAsUserInfoTransfer(transferMessage, withSuccess: success, withFailure: failure)
            }
            #endif
        }
    }
    
    #if os(iOS)
    func sendMessageAsComplicationUpdate(_ transferMessage: TransferMessage, withSuccess success: @escaping WatchCommunicationSuccessHandler, withFailure failure: @escaping WatchCommunicationFailureHandler<TransferError>) {
        let _ = wcSession.transferCurrentComplicationUserInfo(transferMessage.userInfo)
    }
    #endif
    
    func sendMessageAsLive(_ transferMessage: TransferMessage, withSuccess success: @escaping (([String:Any])?) -> (), withFailure failure: @escaping WatchCommunicationFailureHandler<TransferError>) {
        wcSession.sendMessage(transferMessage.userInfo, replyHandler: { (replyInfo) in
            success(replyInfo)
        }) { (error) in
            print(error.localizedDescription)
            let _ = self.wcSession.transferUserInfo(transferMessage.userInfo)
        }
    }
    
    func sendMessageAsUserInfoTransfer(_ transferMessage: TransferMessage, withSuccess success: @escaping WatchCommunicationSuccessHandler, withFailure failure: @escaping WatchCommunicationFailureHandler<TransferError>) {
        let _ = wcSession.transferUserInfo(transferMessage.userInfo)
    }
}

// MARK: - WCSessionDelegate
extension Communicator: WCSessionDelegate {
    #if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) {}
    
    public func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            errorDelegate?.sessionActivationDidFail(activationState, with: error)
        }
        
        switch activationState {
        case .inactive, .notActivated: session.activate()
        default: break
        }
    }
    
    public func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        if let error = error {
            errorDelegate?.userInfoTransferFailed(userInfoTransfer, with: error)
        }
    }
    
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let receivedMessage = ReceivedMessage(userInfo: message, synchronous: false)
        messageHandler.handleMessage(receivedMessage, replyHandler: nil)
    }
    
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let receivedMessage = ReceivedMessage(userInfo: message, synchronous: true)
        messageHandler.handleMessage(receivedMessage, replyHandler: replyHandler)
        
    }
    
    public func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        let receivedMessage = ReceivedMessage(userInfo: userInfo, synchronous: false)
        messageHandler.handleMessage(receivedMessage, replyHandler: nil)
    }
    
    public func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        if let error = error {
            errorDelegate?.fileTransferFailed(fileTransfer, with: error)
        }
    }
}
