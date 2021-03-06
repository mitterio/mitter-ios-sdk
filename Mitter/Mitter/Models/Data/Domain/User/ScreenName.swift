//
//  ScreenName.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 06/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct ScreenName {
    public let screenName: String
}

extension ScreenName: Equatable, Mappable {
    public init(map: Mapper) throws {
        try screenName = map.from("screenName")
    }
    
    public static func ==(lhs: ScreenName, rhs: ScreenName) -> Bool {
        guard lhs.screenName == rhs.screenName else {
            return false
        }
        
        return true
    }
}
