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
    private let userAuthToken: String
    private let userApiContainer: UserApiContainer
    
    public init(userAuthToken: String) {
        self.userAuthToken = userAuthToken
        do {
            let jwt = try decode(jwt: self.userAuthToken)
            print("App ID: \(jwt.body["applicationId"])")
        } catch {
            
        }
        userApiContainer = UserApiContainer()
    }
    
    public func getUser(userId: String, completion: @escaping (Result<User>) -> Void) {
        let fetchUserAction = userApiContainer.getFetchUserAction()
        
        fetchUserAction.execute(t: userId)
            .subscribe { event in
                switch event {
                case .success(let user):
                    completion(Result.success(user))
                case .error:
                    completion(Result.error)
                }
        }
    }
}
