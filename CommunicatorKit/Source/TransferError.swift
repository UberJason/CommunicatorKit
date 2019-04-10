//
//  FeedingError.swift
//  FeedingKit
//
//  Created by Jason Ji on 3/30/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

import Foundation

public enum TransferError: String, Error {
    case transferNotSupported, notPaired, sessionNotActive, notReachable, appNotInstalled, unexpectedMessage, unconfiguredMessageHandler, other
    
    public var localizedDescription: String {
        return self.rawValue
    }
}
