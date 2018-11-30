//
//  AddChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 30/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddChannelAction: UniParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        return channelRepository.addChannel(channel: t)
    }
}
