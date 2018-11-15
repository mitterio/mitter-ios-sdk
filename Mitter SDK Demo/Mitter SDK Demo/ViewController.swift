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
            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6Iko5TUNlbFQ2ZWFPa015dTAiLCJ1c2VydG9rZW4iOiJwYWxjaWJvNGVuYjcydGdzbGNzM25oMGZzNiIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6ImNzckN5LVNKTDN1LThBS01ULVdxdjZ5In0.g334Y-hor1yv9suHFlQZjV4c-ckiUInEWOjC9JSNSLAxSHv5HZvxk7BzI0bwMt_CZ5iR8_MwCGQ46duNS7hZ0g"
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
    }
}
