//
//  DateExtensions.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 23/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

func getCurrentTimeInMillis() -> Int64 {
    return Int64(Date().timeIntervalSince1970 * 1000)
}
