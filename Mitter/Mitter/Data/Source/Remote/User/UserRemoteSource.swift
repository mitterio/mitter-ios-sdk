//
//  UserRemoteSource.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 09/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class UserRemoteSource: UserRepositoryContract {
    private let apiProvider: MoyaProvider<UserApiService>
    
    init(apiProvider: MoyaProvider<UserApiService>) {
        self.apiProvider = apiProvider
    }
    
    func fetchUser(userId: String) -> PrimitiveSequence<SingleTrait, User> {
        return apiProvider
            .rx
            .request(.fetchUser(userId: userId))
            .map(to: User.self)
    }
    
    func fetchUserPresence(userId: String) -> PrimitiveSequence<SingleTrait, Presence> {
        return apiProvider
            .rx
            .request(.fetchUserPresence(userId: userId))
            .map(to: Presence.self)
    }
    
    func setUserPresence(userId: String, presence: Presence) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
            .rx
            .request(.setUserPresence(userId: userId, presence: presence))
            .map(to: Empty.self)
    }
    
    func addUserDeliveryEndpoint(
        userId: String,
        fcmDeliveryEndpoint: FcmDeliveryEndpoint
        ) -> PrimitiveSequence<SingleTrait, DeliveryEndpoint> {
        return apiProvider
            .rx
            .request(.addUserDeliveryEndpoint(userId: userId, fcmDeliveryEndpoint: fcmDeliveryEndpoint))
            .map(to: DeliveryEndpoint.self)
    }
}
