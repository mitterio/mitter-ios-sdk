//
//  FetchUserPresenceAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 22/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchUserPresencesAction: UniParamAction {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t: [String]) -> PrimitiveSequence<SingleTrait, [UserPresence]> {
        return userRepository.fetchUserPresences(userIds: t)
    }
}
