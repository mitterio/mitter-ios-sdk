//
//  ChannelRepositoryContract.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol ChannelRepositoryContract {
    func fetchChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Channel>
    
    func fetchChannelsForUser(userId: String) -> PrimitiveSequence<SingleTrait, [ParticipatedChannel]>
    
    func fetchParticipantsForChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [ChannelParticipation]>
    
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>>
    
    func addParticipantToChannel(
        channelId: String,
        channelParticipation: ChannelParticipation
        ) -> PrimitiveSequence<SingleTrait, Empty>
    
    func removeChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Empty>
}
