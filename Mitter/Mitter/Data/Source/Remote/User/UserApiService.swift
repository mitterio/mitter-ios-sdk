//
//  UserApiService.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 06/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya

enum UserApiService {
    case getUser(userId: String)
}

extension UserApiService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.staging.mitter.io")!
    }
    
    var path: String {
        switch self {
        case .getUser(let userId):
            return "/v1/users/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "X-Mitter-Application-Id": "MZzf4-na9nL-O98wq-M1HxS",
            "X-Issued-Mitter-User-Authorization": "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6IkZ4cWpEbVhZY2tlcnVIWEMiLCJ1c2VydG9rZW4iOiJraHFuNWphbGFtajBpZjdla3RxcjF1b2dibiIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6IkUzQ0FNLWpqdzhBLVdlcURlLWNXRmU3In0.AYVqNPPu3gMS9GWas4ookNwgrruRDtyiBRvAlnn4CROS5Lvh91IdIG2pvpxOe-WyS21T9nKps4FI0c1xsU1OlQ"
        ]
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
