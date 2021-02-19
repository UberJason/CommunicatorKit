//
//  TransferMessage.swift
//  FeedingKit
//
//  Created by Jason Ji on 3/30/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

import Foundation

public protocol TransferMessage {
    var userInfo: [String:Any] { get }
    var synchronous: Bool { get }
}
