//
//  AddParticipantToChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 22/01/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddParticipantToChannelAction: BiParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t1: String, t2: Participant) -> PrimitiveSequence<SingleTrait, Empty> {
        let channelParticipation = convertToChannelParticipation(participant: t2)
        return channelRepository.addParticipantToChannel(channelId: t1, channelParticipation: channelParticipation)
    }
}
