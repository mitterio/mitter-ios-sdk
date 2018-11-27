//
//  AddDirectMessageChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddDirectMessageChannelAction: UniParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t: [Participant]) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        let channelParticipationList = convertToChannelParticipationList(participants: t)
        
        let channel = Channel(
            channelId: UUID().uuidString,
            defaultRuleSet: StandardRuleSetNames.DirectMessage,
            participation: channelParticipationList
        )
        
        return channelRepository.addChannel(channel: channel)
    }
}
