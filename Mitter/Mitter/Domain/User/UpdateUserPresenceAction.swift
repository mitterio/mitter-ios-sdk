//
//  UpdateUserPresenceAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 22/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class UpdateUserPresenceAction: BiParamAction {
    typealias T1 = String
    typealias T2 = Presence
    typealias V = Empty
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t1: String, t2: Presence) -> PrimitiveSequence<SingleTrait, Empty> {
        return userRepository.setUserPresence(userId: t1, presence: t2)
    }
}
