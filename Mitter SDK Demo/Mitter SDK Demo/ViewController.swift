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
        mitter.testPrint()
    }
}

