//
//  ValidationResult.swift
//  FeedingKit
//
//  Created by Jason Ji on 3/30/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

import Foundation

public enum ValidationResult {
    case success, error(TransferError)
}
