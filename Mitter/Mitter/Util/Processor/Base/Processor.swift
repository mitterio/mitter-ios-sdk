//
//  Processor.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

protocol Processor {
    associatedtype T
    associatedtype V
    
    func process(t: T) -> V
}
