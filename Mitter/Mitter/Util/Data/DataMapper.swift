//
//  DataMapper.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

func convertToChannelParticipation(participant: Participant) -> ChannelParticipation {
    return ChannelParticipation(participantId: Identifiable<User>(domainId: participant.id))
}

func convertToChannelParticipationList(participants: [Participant]) -> [ChannelParticipation] {
    return participants.map { convertToChannelParticipation(participant: $0) }
}
