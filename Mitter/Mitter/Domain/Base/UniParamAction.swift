//
//  UniParamAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 09/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol UniParamAction {
    associatedtype T
    associatedtype V
    
    func execute(t: T) -> PrimitiveSequence<SingleTrait, V>
}
