//
//  Mitter.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 05/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxSwift
import Swinject
import JWTDecode

public class Mitter {
    private var applicationId: String
    private var userId: String
    private var userAuthToken: AuthToken
    
    private let libDefaults: LibDefaults
    private let userApiContainer: UserApiContainer
    private let disposeBag = DisposeBag()
    
    public init(applicationId: String, userAuthToken: String = "") {
        self.applicationId = applicationId
        self.userAuthToken = AuthToken(id: "", signedToken: userAuthToken)
        
        let jwt = try? decode(jwt: self.userAuthToken.signedToken)
        userId = "\(jwt?.body["userId"] ?? "")"
        
        libDefaults = LibDefaults(applicationId: applicationId)
        userApiContainer = UserApiContainer()
        
        setUserId(userId)
    }
    
    public func getUserId() -> String {
        if userId.isEmpty {
            return libDefaults.getUserId()
        }
        
        return userId
    }
    
    public func setUserId(_ userId: String) {
        self.userId = userId
        libDefaults.saveUserId(userId: userId)
    }
    
    public func getUserAuthToken() -> AuthToken {
        if userAuthToken.signedToken.isEmpty {
            return libDefaults.getToken()
        }
        
        return userAuthToken
    }
    
    public func setUserAuthToken(_ userAuthToken: String) {
        self.userAuthToken = AuthToken(id: "", signedToken: userAuthToken)
        libDefaults.saveToken(authToken: self.userAuthToken)
    }
    
    public func getUser(_ userId: String, completion: @escaping (Result<User>) -> Void) {
        let fetchUserAction = userApiContainer.getFetchUserAction()
        
        fetchUserAction
            .execute(t: userId)
            .subscribe { event in
                switch event {
                case .success(let user):
                    completion(Result.success(user))
                case .error:
                    completion(Result.error)
                }
            }.disposed(by: disposeBag)
    }
    
    public func getCurrentUser(completion: @escaping (Result<User>) -> Void) {
        getUser(userId, completion: completion)
    }
}
