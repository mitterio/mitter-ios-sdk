//
//  DataExtensions.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

extension Array {
    func flattenWithCommas() -> String {
        let reducedArray = self.reduce("", { reduced, element in
            "\(reduced),\(element)"
        })
        
        if reducedArray.isEmpty {
            return ""
        } else {
            let index = reducedArray.index(reducedArray.startIndex, offsetBy: 1)
            return String(reducedArray[index...])
        }
    }
}
