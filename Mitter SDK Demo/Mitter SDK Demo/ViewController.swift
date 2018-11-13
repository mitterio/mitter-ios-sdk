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
            applicationId: "bECxP-iwZKH-mk1cs-kvnop",
            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6IlY1VVZQUjRXTTlGaUtNU2giLCJ1c2VydG9rZW4iOiJncTU1NXFkaDh1bzkxbW1oNGpjOTl1YW9jNiIsImFwcGxpY2F0aW9uSWQiOiJiRUN4UC1pd1pLSC1tazFjcy1rdm5vcCIsInVzZXJJZCI6ImFpNkUzLUVBanVYLUprRGhiLThZcUJxIn0.yPQPIZQ1k9UEz2nXgItcdzOcd57n9LjkMwa3Ogr1UfWOebaoIOzW3G-uKyZNFb1snvMkVWhdknMKFYVJWr9Owg"
        )
        mitter.getUser("ai6E3-EAjuX-JkDhb-8YqBq") {
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
