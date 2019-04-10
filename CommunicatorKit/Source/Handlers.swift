//
//  HandlerSet.swift
//  FeedingKit
//
//  Created by Jason Ji on 4/5/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

import Foundation

// Only a live message will send back replyInfo. Other types of messages will call the success handler with nil.
public typealias WatchCommunicationSuccessHandler = (_ replyInfo: [String:Any]?) -> ()
public typealias WatchCommunicationFailureHandler<Error> = (_ error: Error) -> ()

