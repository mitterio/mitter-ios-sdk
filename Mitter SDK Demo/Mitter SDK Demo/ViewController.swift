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
        let mitter = Mitter()
        mitter.getUser(userId: "E3CAM-jjw8A-WeqDe-cWFe7")
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

