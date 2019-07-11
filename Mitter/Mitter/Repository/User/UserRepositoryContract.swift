//
//  UserRepositoryContract.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 09/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryContract {
    func fetchUser(userId: String) -> PrimitiveSequence<SingleTrait, User>
    
    func fetchUserPresences(userIds: [String]) -> PrimitiveSequence<SingleTrait, [UserPresence]>
    
    func fetchUsersByLocators(locators: [String]) -> PrimitiveSequence<SingleTrait, [User]>
    
    func authenticateGoogleSignIn(token: String) -> PrimitiveSequence<SingleTrait, FederatedUserRegistration>
    
    func setUserPresence(
        userId: String,
        presence: Presence
    ) -> PrimitiveSequence<SingleTrait, Empty>
    
    func addUserDeliveryEndpoint(
        userId: String,
        fcmDeliveryEndpoint: FcmDeliveryEndpoint
    ) -> PrimitiveSequence<SingleTrait, DeliveryEndpoint>
}
