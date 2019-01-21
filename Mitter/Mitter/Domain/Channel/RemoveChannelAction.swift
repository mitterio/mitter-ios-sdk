//
//  RemoveChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 21/01/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class RemoveChannelAction: UniParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t: String) -> PrimitiveSequence<SingleTrait, Empty> {
        return channelRepository.removeChannel(channelId: t)
    }
}
