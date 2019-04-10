//
//  MessageHandler.swift
//  FeedingKit
//
//  Created by Jason Ji on 4/9/19.
//  Copyright © 2019 Jason Ji. All rights reserved.
//

import Foundation
import os.log

public protocol MessageHandler: class {
    func handleMessage(_ message: TransferMessage, replyHandler: (([String : Any]) -> Void)?)
}
