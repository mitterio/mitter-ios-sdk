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

public class Mitter {
    let provider = MoyaProvider<UserApiService>()
    
    public init() {
   
    }
    
    public func testPrint() {
        print("Welcome to Mitter!")
    }
    
    public func getUser(userId: String) -> PrimitiveSequence<SingleTrait, User> {
        return provider
            .rx
            .request(.getUser(userId: userId))
            .map(to: User.self)
    }
}
