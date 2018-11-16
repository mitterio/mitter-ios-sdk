//
//  StandardTimelineEventTypeNames.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public enum StandardTimelineEventTypeNames {
    public static let CreationTime: String = "io.mitter.types.timeline.CreationTime"
    
    enum Messages {
        public static let SentTime: String = "mitter.mtet.SentTime"
        public static let ReceivedTime: String = "mitter.mtet.ReceivedTime"
        public static let DeliveredTime: String = "mitter.mtet.DeliveredTime"
        public static let ReadTime: String = "mitter.mtet.ReadTime"
    }
}
