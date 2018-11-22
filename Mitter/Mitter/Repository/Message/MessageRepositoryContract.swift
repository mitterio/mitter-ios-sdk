//
//  MessageRepositoryContract.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol MessageRepositoryContract {
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message>
}
