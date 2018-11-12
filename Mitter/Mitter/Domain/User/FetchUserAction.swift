//
//  FetchUserAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 12/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchUserAction: UniParamAction {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t: String) -> PrimitiveSequence<SingleTrait, User> {
        return userRepository.fetchUser(userId: t)
    }
}
