//
//  ReceivedMessage.swift
//  FeedingKit
//
//  Created by Jason Ji on 4/9/19.
//  Copyright © 2019 Jason Ji. All rights reserved.
//

import Foundation

public struct ReceivedMessage: TransferMessage {
    public var userInfo: [String:Any]
    public var synchronous: Bool
    
    public init(userInfo: [String:Any], synchronous: Bool) {
        self.userInfo = userInfo
        self.synchronous = synchronous
    }
}
