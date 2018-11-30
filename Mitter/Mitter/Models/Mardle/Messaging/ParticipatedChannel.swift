//
//  ParticipatedChannel.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 30/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct ParticipatedChannel {
    public let participationStatus: ParticipationStatus
    public let channel: Channel
}

extension ParticipatedChannel: Mappable {
    public init(map: Mapper) throws {
        participationStatus = try map.from("participationStatus")
        channel = try map.from("channel")
    }
}
