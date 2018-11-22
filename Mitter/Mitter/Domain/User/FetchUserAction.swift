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
    typealias T = String
    typealias V = User
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t: FetchUserAction.T) -> PrimitiveSequence<SingleTrait, FetchUserAction.V> {
        return userRepository.fetchUser(userId: t)
    }
}
