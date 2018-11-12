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

public class Mitter {
    private let userApiContainer: UserApiContainer
    
    public init() {
        userApiContainer = UserApiContainer()
    }
    
    public func testPrint() {
        print("Welcome to Mitter!")
    }
    
    public func getUser(userId: String) {
        let fetchUserAction = userApiContainer.container.resolve(Action.self, name: Constants.Users.Actions.fetchUser) as! FetchUserAction
        fetchUserAction.execute(t: userId)
            .subscribe { event in
                switch event {
                case .success(let user):
                    print(user)
                    
                    if user.screenName != nil {
                        print("Current User is: \(user.screenName!.screenName)")
                    }
                case .error(let error):
                    print(error)
                }
        }
    }
}
