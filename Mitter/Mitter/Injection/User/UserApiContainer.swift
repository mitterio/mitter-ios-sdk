//
//  UserApiContainer.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 12/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Swinject
import Moya

class UserApiContainer {
    private let container: Container

    init() {
        container = Container()
        registerUserApiLayers()
    }
    
    func getFetchUserAction() -> FetchUserAction {
        return container.resolve(
            Action.self,
            name: Constants.Users.Actions.fetchUser
            ) as! FetchUserAction
    }
    
    private func registerUserApiLayers() {
        container.register(UserRepositoryContract.self, name: Constants.Users.userRemoteSource) {
            _ in UserRemoteSource(apiProvider: MoyaProvider<UserApiService>())
        }
        
        container.register(UserRepositoryContract.self, name: Constants.Users.userRepository) {
            resolver in UserRepository(
                userRemoteSource: resolver.resolve(
                    UserRepositoryContract.self,
                    name: Constants.Users.userRemoteSource
                ) as! UserRemoteSource
            )
        }
        
        container.register(Action.self, name: Constants.Users.Actions.fetchUser) {
            resolver in FetchUserAction(
                userRepository: resolver.resolve(
                    UserRepositoryContract.self,
                    name: Constants.Users.userRepository
                ) as! UserRepository
            )
        }
    }
}
