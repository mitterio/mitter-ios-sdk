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
    private let applicationId: String
    private let userAuthToken: String
    
    private let container: Container
    
    init(applicationId: String, userAuthToken: String) {
        self.applicationId = applicationId
        self.userAuthToken = userAuthToken
        
        container = Container()
        registerUserApiLayers()
    }
    
    func getPushMessageManager() -> PushMessageManager {
        return PushMessageManager(fcmMessageProcessor: getFcmMessageProcessor())
    }
    
    func getFetchUserAction() -> FetchUserAction {
        return FetchUserAction(userRepository: getUserRepository())
    }
    
    func getFetchUserPresenceAction() -> FetchUserPresenceAction {
        return FetchUserPresenceAction(userRepository: getUserRepository())
    }
    
    func getFetchUsersByLocatorsAction() -> FetchUsersByLocatorsAction {
        return FetchUsersByLocatorsAction(userRepository: getUserRepository())
    }
    
    func getUpdateUserPresenceAction() -> UpdateUserPresenceAction {
        return UpdateUserPresenceAction(userRepository: getUserRepository())
    }
    
    func getAddFcmDeliveryEndpointAction() -> AddFcmDeliveryEndpointAction {
        return AddFcmDeliveryEndpointAction(userRepository: getUserRepository())
    }
    
    func getAuthenticateGoogleSignInAction() -> AuthenticateGoogleSignInAction {
        return AuthenticateGoogleSignInAction(userRepository: getUserRepository())
    }
    
    private func getFcmMessageProcessor() -> FcmMessageProcessor {
        return FcmMessageProcessor()
    }
    
    private func registerUserApiLayers() {
        container.register(UserRepositoryContract.self, name: Constants.Users.userRemoteSource) {
            _ in UserRemoteSource(
                apiProvider: MoyaProvider<UserApiService>(
                    plugins: [
                        ApiAuthPlugin(
                            applicationId: self.applicationId,
                            userAuthToken: self.userAuthToken
                        ),
                        NetworkLoggerPlugin(verbose: true)
                    ]
                )
            )
        }
        
        container.register(UserRepositoryContract.self, name: Constants.Users.userRepository) {
            resolver in UserRepository(
                userRemoteSource: resolver.resolve(
                    UserRepositoryContract.self,
                    name: Constants.Users.userRemoteSource
                    ) as! UserRemoteSource
            )
        }
    }
    
    private func getUserRepository() -> UserRepository {
        return container.resolve(
            UserRepositoryContract.self,
            name: Constants.Users.userRepository
        ) as! UserRepository
    }
}
