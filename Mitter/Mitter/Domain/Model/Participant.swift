//
//  Participant.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public struct Participant {
    public let id: String
    public let status: ParticipationStatus
    
    public init(id: String, status: ParticipationStatus = ParticipationStatus.Active) {
        self.id = id
        self.status = status
    }
}
