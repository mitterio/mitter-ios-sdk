//
//  AuthenticateGoogleSignInAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 11/02/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AuthenticateGoogleSignInAction: UniParamAction {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(t: String) -> PrimitiveSequence<SingleTrait, FederatedUserRegistration> {
        return userRepository.authenticateGoogleSignIn(token: t)
    }
}
