//
//  MessageDatum.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct MessageDatum {
    public let dataType: String
    public let data: Dictionary<String, Any>
    
    public init(dataType: String, data: Dictionary<String, Any>) {
        self.dataType = dataType
        self.data = data
    }
}

extension MessageDatum: Mappable {
    public init(map: Mapper) throws {
        dataType = try map.from("dataType")
        data = try map.from("data", transformation: convertToDictionary)
    }
}

private func convertToDictionary(object: Any?) throws -> Dictionary<String, Any> {
    guard let nsDictionary = object as? NSDictionary else {
        return Dictionary<String, Any>()
    }
    
    var dictionary = Dictionary<String, Any>()
    
    for key : Any in nsDictionary.allKeys {
        let stringKey = key as! String
        if let keyValue = nsDictionary.value(forKey: stringKey){
            dictionary[stringKey] = keyValue
        }
    }
    
    return dictionary
}
