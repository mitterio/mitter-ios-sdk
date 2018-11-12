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
        let mitter = Mitter(userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6Ikl6blBOMFNHWnNvUGE1SGMiLCJ1c2VydG9rZW4iOiJqMmJ1MTYyZzBya2U3cm5jZmczbjlzOW4wciIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6IkUzQ0FNLWpqdzhBLVdlcURlLWNXRmU3In0.9YM-NKAmXPyAAya-5Bw3Ck7g5jtlDrhp7BwfJwpCKdAYesEKrC491hmrL_kzgZM9Ic9kHniqUcPoYc9tLImfqA")
        mitter.getUser(userId: "E3CAM-jjw8A-WeqDe-cWFe7") {
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
