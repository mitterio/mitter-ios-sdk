//
//  AddFcmDeliveryEndpointAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddFcmDeliveryEndpointAction: BiParamAction {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t1: String, t2: String) -> PrimitiveSequence<SingleTrait, DeliveryEndpoint> {
        let fcmDeliveryEndpoint = FcmDeliveryEndpoint(registrationToken: t2)
        return userRepository.addUserDeliveryEndpoint(userId: t1, fcmDeliveryEndpoint: fcmDeliveryEndpoint)
    }
}
