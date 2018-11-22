//
//  Empty.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 22/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Empty: Mappable {
    public init() {}
    public init(map: Mapper) throws {}
}
