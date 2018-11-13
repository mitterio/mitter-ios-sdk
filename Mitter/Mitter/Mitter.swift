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
    private let applicationId: String
    private let userId: String
    private let userAuthToken: String
    
    private let userApiContainer: UserApiContainer
    private let disposeBag = DisposeBag()
    
    public init(applicationId: String, userAuthToken: String = "") {
        self.applicationId = applicationId
        self.userAuthToken = userAuthToken
        
        do {
            let jwt = try decode(jwt: self.userAuthToken)
            userId = "\(jwt.body["userId"] ?? "")"
        } catch {
            userId = ""
        }
        
        userApiContainer = UserApiContainer()
    }
    
    public func getUser(userId: String, completion: @escaping (Result<User>) -> Void) {
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
        getUser(userId: userId, completion: completion)
    }
}
