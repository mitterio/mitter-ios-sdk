//
//  ViewController.swift
//  Mitter SDK Demo
//
//  Created by Rahul Chowdhury on 05/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import UIKit
import Mitter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testSDK()
    }
    
    func testSDK() {
        let mitter = Mitter(
            applicationId: "MZzf4-na9nL-O98wq-M1HxS",
            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6ImVPcm8xN0tyTFN4dklnWEgiLCJ1c2VydG9rZW4iOiJvYWo2YWFsNjM2Z2twZTF2bjVoYzFoZjE5NyIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6ImNzckN5LVNKTDN1LThBS01ULVdxdjZ5In0.5Rhs_9Rls_1IIIu3e-rFcRKnpqVAFixofjJB88MyFxQdDy0q2d287vi89fAmuetk3dJ7mzKkssIUDvEjkvxsJg"
        )
        mitter.users.getCurrentUser {
            result in
            switch result {
            case .success(let user):
                print("Current User is: \(user.screenName!.screenName)")
            case .error:
                print("Unable to get user!")
            }
        }
        
        mitter.registerFcmToken(token: "63hbjhsbjcjkshcjksffhgs") {
            result in
            switch result {
            case .success(let deliveryEndpoint):
                print("Endpoint is: \(deliveryEndpoint)")
            case .error:
                print("Unable to register endpoint!")
            }
        }
    }
}
