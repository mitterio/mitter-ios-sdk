//
//  BiParamAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol BiParamAction {
    associatedtype T1
    associatedtype T2
    associatedtype V
    
    func execute(t1: T1, t2: T2) -> PrimitiveSequence<SingleTrait, V>
}
