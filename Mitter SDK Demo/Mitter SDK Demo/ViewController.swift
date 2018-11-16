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
            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6ImptMmJIN29pam5nTUhJQmYiLCJ1c2VydG9rZW4iOiJqc201cG1zOG9xa2FvM243cGI4dTg0ZGxhOSIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6ImNzckN5LVNKTDN1LThBS01ULVdxdjZ5In0.j8zHSg7Pb73T9t-6unAcuKN80ElVsukxfCLYd2UTP3VrHPDOec55To-4qO9m2MxwSbQUoyslCL_n0KIEhd2_3A"
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
        
//        mitter.registerFcmToken(token: "63hbjhsbjcjkshcjks884jsjsjffhgs") {
//            result in
//            switch result {
//            case .success(let deliveryEndpoint):
//                print("Endpoint is: \(deliveryEndpoint.serializedEndpoint)")
//            case .error:
//                print("Unable to register endpoint!")
//            }
//        }
        
        mitter.messaging.getMessage("ID9QN-PL522-DRtDA-wf70q") { result in
            switch result {
            case .success(let message):
                print("Message is: \(message.textPayload)")
                print("Message sent by: \(message.senderId.domainId)")
            case .error:
                print("Unable to fetch message from server")
            }
        }
    }
}
