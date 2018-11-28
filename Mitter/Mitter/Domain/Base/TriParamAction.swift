//
//  TriParamAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 28/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol TriParamAction {
    associatedtype T1
    associatedtype T2
    associatedtype T3
    associatedtype V
    
    func execute(t1: T1, t2: T2, t3: T3) -> PrimitiveSequence<SingleTrait, V>
}
