//
//  ImpressedPresence.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 11/07/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct ImpressedPresence {
    public let setTimeMs: Int64?
    public let presence: Presence?
}

extension ImpressedPresence: Mappable {
    public init(map: Mapper) throws {
        setTimeMs = map.optionalFrom("setTime")
        presence = map.optionalFrom("presence")
    }
}
