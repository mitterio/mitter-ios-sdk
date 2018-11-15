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
    
    func addUserDeliveryEndpoint(
        userId: String,
        deliveryEndpoint: DeliveryEndpoint
    ) -> PrimitiveSequence<SingleTrait, DeliveryEndpoint>
}
