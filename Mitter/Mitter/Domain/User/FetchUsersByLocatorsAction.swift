//
//  FetchUsersByLocatorsAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 24/01/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchUsersByLocatorsAction: UniParamAction {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t: [String]) -> PrimitiveSequence<SingleTrait, [User]> {
        return userRepository.fetchUsersByLocators(locators: t)
    }
}
