//
//  AppliedAclList.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct AppliedAclList {
    public let plusAppliedAcls: [String]
    public let minusAppliedAcls: [String]
    
    public init(
        plusAppliedAcls: [String],
        minusAppliedAcls: [String]
        ) {
        self.plusAppliedAcls = plusAppliedAcls
        self.minusAppliedAcls = minusAppliedAcls
    }
}

extension AppliedAclList: Mappable {
    public init(map: Mapper) throws {
        plusAppliedAcls = try map.from("plusAppliedAcls")
        minusAppliedAcls = try map.from("minusAppliedAcls")
    }
}
