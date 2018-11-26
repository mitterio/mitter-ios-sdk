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
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>>
}
