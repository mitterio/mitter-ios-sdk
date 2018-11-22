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
    typealias T1 = String
    typealias T2 = String
    typealias V = DeliveryEndpoint
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t1: AddFcmDeliveryEndpointAction.T1, t2: AddFcmDeliveryEndpointAction.T2) -> PrimitiveSequence<SingleTrait, AddFcmDeliveryEndpointAction.V> {
        let fcmDeliveryEndpoint = FcmDeliveryEndpoint(registrationToken: t2)
        return userRepository.addUserDeliveryEndpoint(userId: t1, fcmDeliveryEndpoint: fcmDeliveryEndpoint)
    }
}
