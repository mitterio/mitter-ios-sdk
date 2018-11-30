//
//  FetchChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 30/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchChannelAction: UniParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t: String) -> PrimitiveSequence<SingleTrait, Channel> {
        return channelRepository.fetchChannel(channelId: t)
    }
}
