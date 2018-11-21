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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        testSDK(appDelegate: appDelegate)
    }
    
    func testSDK(appDelegate: AppDelegate) {

        appDelegate.mitter.users.getCurrentUser {
            result in
            switch result {
            case .success(let user):
                print("Current User is: \(user.screenName!.screenName)")
            case .error:
                print("Unable to get user!")
            }
        }
        
        appDelegate.mitter.messaging.getMessage("Hya1L-ezC8l-tCIIo-LAGbe") { result in
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
