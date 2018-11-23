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
        //        appDelegate.mitter.users.getCurrentUser {
        //            result in
        //            switch result {
        //            case .success(let user):
        //                print("Current User is: \(user)")
        //            case .error:
        //                print("Unable to get user!")
        //            }
        //        }
        
        //        appDelegate.mitter.messaging.getMessage("I1uK0-9d93j-1uhXl-J3suo") { result in
        //            switch result {
        //            case .success(let message):
        //                print("Message is: \(message)")
        //                print("Message sent by: \(message.senderId.domainId)")
        //            case .error:
        //                print("Unable to fetch message from server")
        //            }
        //        }
        
        //        appDelegate.mitter.users.getCurrentUserPresence { result in
        //            switch result {
        //            case .success(let userPresence):
        //                print("Presence is: \(userPresence.type)")
        //                print("Expires to: \(userPresence.expiresTo?.type)")
        //            case .error:
        //                print("Unable to fetch presence from server")
        //            }
        //        }
        
        //        let away = Presence(
        //            type: StandardUserPresenceTypeNames.Away,
        //            timeToLive: 0
        //        )
        //        let online = Presence(
        //            type: StandardUserPresenceTypeNames.Online,
        //            timeToLive: 60,
        //            expiresTo: away
        //        )
        //        appDelegate.mitter.users.setCurrentUserPresence(online) { result in
        //            switch result {
        //            case .success:
        //                print("Presence Updated!")
        //            case .error:
        //                print("Unable to update presence")
        //            }
        //
        //        }
        
        appDelegate.mitter.messaging.sendTextMessage(
            forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
            "Hello from iOS!"
        ) { result in
            switch result {
            case .success:
                print("Message sent!")
            case .error:
                print("Couldn't send message")
            }
        }
    }
}
