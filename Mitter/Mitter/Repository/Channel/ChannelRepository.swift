//
//  ChannelRepository.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class ChannelRepository: ChannelRepositoryContract {
    private let channelRemoteSource: ChannelRemoteSource
    
    init(channelRemoteSource: ChannelRemoteSource) {
        self.channelRemoteSource = channelRemoteSource
    }
    
    func fetchChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Channel> {
        return channelRemoteSource.fetchChannel(channelId: channelId)
    }
    
    func fetchChannelsForUser(userId: String) -> PrimitiveSequence<SingleTrait, [ParticipatedChannel]> {
        return channelRemoteSource.fetchChannelsForUser(userId: userId)
    }
    
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        return channelRemoteSource.addChannel(channel: channel)
    }
}
