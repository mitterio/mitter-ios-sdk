//
//  UserRepository.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 09/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class UserRepository: UserRepositoryContract {
    private let userRemoteSource: UserRemoteSource
    
    init(userRemoteSource: UserRemoteSource) {
        self.userRemoteSource = userRemoteSource
    }
    
    func fetchUser(userId: String) -> PrimitiveSequence<SingleTrait, User> {
        return userRemoteSource.fetchUser(userId: userId)
    }
    
    func fetchUserPresence(userId: String) -> PrimitiveSequence<SingleTrait, Presence> {
        return userRemoteSource.fetchUserPresence(userId: userId)
    }
    
    func setUserPresence(userId: String, presence: Presence) -> PrimitiveSequence<SingleTrait, Empty> {
        return userRemoteSource.setUserPresence(userId: userId, presence: presence)
    }
    
    func addUserDeliveryEndpoint(
        userId: String,
        fcmDeliveryEndpoint: FcmDeliveryEndpoint
        ) -> PrimitiveSequence<SingleTrait, DeliveryEndpoint> {
        return userRemoteSource.addUserDeliveryEndpoint(
            userId: userId,
            fcmDeliveryEndpoint: fcmDeliveryEndpoint
        )
    }
}
