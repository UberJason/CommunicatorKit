//
//  CommunicatorErrorDelegate.swift
//  FeedingKit
//
//  Created by Jason Ji on 4/9/19.
//  Copyright © 2019 Jason Ji. All rights reserved.
//

import Foundation
import WatchConnectivity

public protocol CommunicatorErrorDelegate: class {
    func sessionActivationDidFail(_ activationState: WCSessionActivationState, with error: Error)
    func userInfoTransferFailed(_ userInfoTransfer: WCSessionUserInfoTransfer, with error: Error)
    func fileTransferFailed(_ fileTransfer: WCSessionFileTransfer, with error: Error)
}

public extension CommunicatorErrorDelegate {
    func sessionActivationDidFail(_ activationState: WCSessionActivationState, with error: Error) {}
    func userInfoTransferFailed(_ userInfoTransfer: WCSessionUserInfoTransfer, with error: Error) {}
    func fileTransferFailed(_ fileTransfer: WCSessionFileTransfer, with error: Error) {}
}
