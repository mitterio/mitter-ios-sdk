//
//  MessageNotification.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public struct MessageNotification {
    public let body: String
    public let icon: String
    public let title: String
    
    public init(body: String, icon: String, title: String) {
        self.body = body
        self.icon = icon
        self.title = title
    }
}

extension MessageNotification {
    func toMessageDatum() -> MessageDatum {
        return MessageDatum(
            dataType: Constants.Keys.notificationDataType,
            data: try! wrapModel(self)
        )
    }
}
