//
//  ViewController.swift
//  Mitter SDK Demo
//
//  Created by Rahul Chowdhury on 05/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import UIKit
import Mitter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        testSDK(appDelegate: appDelegate)
    }
    
    func testSDK(appDelegate: AppDelegate) {
        //        appDelegate.mitter.users.getCurrentUser {
        //            result in
        //            switch result {
        //            case .success(let user):
        //                print("Current User is: \(user)")
        //            case .error:
        //                print("Unable to get user!")
        //            }
        //        }
        
        //        appDelegate.mitter.messaging.getMessage("I1uK0-9d93j-1uhXl-J3suo") { result in
        //            switch result {
        //            case .success(let message):
        //                print("Message is: \(message)")
        //                print("Message sent by: \(message.senderId.domainId)")
        //            case .error:
        //                print("Unable to fetch message from server")
        //            }
        //        }
        
        //        appDelegate.mitter.users.getCurrentUserPresence { result in
        //            switch result {
        //            case .success(let userPresence):
        //                print("Presence is: \(userPresence.type)")
        //                print("Expires to: \(userPresence.expiresTo?.type)")
        //            case .error:
        //                print("Unable to fetch presence from server")
        //            }
        //        }
        
        //        let away = Presence(
        //            type: StandardUserPresenceTypeNames.Away,
        //            timeToLive: 0
        //        )
        //        let online = Presence(
        //            type: StandardUserPresenceTypeNames.Online,
        //            timeToLive: 60,
        //            expiresTo: away
        //        )
        //        appDelegate.mitter.users.setCurrentUserPresence(online) { result in
        //            switch result {
        //            case .success:
        //                print("Presence Updated!")
        //            case .error:
        //                print("Unable to update presence")
        //            }
        //
        //        }
        
//        let notification = MessageNotification(body: "Hello there!", icon: "default.ico", title: "Yo!")
//                appDelegate.mitter.messaging.sendTextMessage(
//                    forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
//                    "Hello from iOS with notification!",
//                    withNotificationDetails: notification
//                ) { result in
//                    switch result {
//                    case .success:
//                        print("Message sent!")
//                    case .error:
//                        print("Couldn't send message")
//                    }
//                }
        
        
//                appDelegate.mitter.messaging.getMessagesInChannel("rakfT-XPdJb-WsucS-Pxy4B") {
//                    result in
//                    switch result {
//                    case .success(let messages):
//                        print("Messages: \(messages)")
//                    case .error:
//                        print("Couldn't fetch messages")
//                    }
//                }
        
        //        let stan = Participant(id: "csrCy-SJL3u-8AKMT-Wqv6y")
        //        let rahul = Participant(id: "E3CAM-jjw8A-WeqDe-cWFe7")
        //        appDelegate.mitter.channels.createDirectMessageChannel(participants: [stan, rahul]) { result in
        //            switch result {
        //            case .success(let channelId):
        //                print("New channel created: \(channelId)")
        //            case .error:
        //                print("Couldn't create channel")
        //            }
        //        }
        
        //        appDelegate.mitter.channels.createGroupMessageChannel(participants: [stan, rahul]) { result in
        //            switch result {
        //            case .success(let channelId):
        //                print("New channel created: \(channelId)")
        //            case .error:
        //                print("Couldn't create channel")
        //            }
        //        }
        
        let fileManager = FileManager.default
        let sampleUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("Directory: \(sampleUrl)")
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: sampleUrl, includingPropertiesForKeys: nil)
            let imageUrl = fileURLs[0]
            print("File URLs: \(fileURLs)")
            
//            appDelegate.mitter.messaging.sendImageMessage(
//                forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
//                withCaption: "Awesome iPhone Shoes!",
//                image: imageUrl) { result in
//                    switch result {
//                    case .success:
//                        print("Image message sent!")
//                    case .error:
//                        print("Couldn't send image message")
//                    }
//
//            }
            
//                        let sender = Identifiable<User>(domainId: "csrCy-SJL3u-8AKMT-Wqv6y")
//
//                        let sentTimelineEvent = TimelineEvent(
//                            eventId: UUID().uuidString,
//                            type: StandardTimelineEventTypeNames.Messages.SentTime,
//                            eventTimeMs: Int64(Date().timeIntervalSince1970 * 1000),
//                            subject: sender
//                        )
//
//                        let message = Message(
//                            messageId: UUID().uuidString,
//                            payloadType: StandardPayloadTypeNames.FileMessage,
//                            senderId: sender,
//                            textPayload: "Wassup",
//                            timelineEvents: [sentTimelineEvent]
//                        )
//
//                        appDelegate.mitter.messaging.sendFileMessage(
//                            forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
//                            withMessage: message,
//                            file: imageUrl
//                        ) { result in
//                            switch result {
//                            case .success:
//                                print("Image uploaded")
//                            case .error:
//                                print("Couldn't upload image")
//                            }
//                        }
        } catch {
            print("Error while enumerating files \(sampleUrl.path): \(error.localizedDescription)")
        }
        
//        let sender = Identifiable<User>(domainId: "csrCy-SJL3u-8AKMT-Wqv6y")
//
//        let sentTimelineEvent = TimelineEvent(
//            eventId: UUID().uuidString,
//            type: StandardTimelineEventTypeNames.Messages.SentTime,
//            eventTimeMs: Int64(Date().timeIntervalSince1970 * 1000),
//            subject: sender
//        )
//
//        let messageDatum = MessageDatum(
//            dataType: "com.acme.custom",
//            data: [
//                "name": "Mitter",
//                "website": "https://mitter.io"
//            ]
//        )
//
//        let message = Message(
//            messageId: UUID().uuidString,
//            payloadType: StandardPayloadTypeNames.TextMessage,
//            senderId: sender,
//            textPayload: "Wassup",
//            messageData: [messageDatum],
//            timelineEvents: [sentTimelineEvent]
//        )
//
//        appDelegate.mitter.messaging.sendMessage(
//            forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
//            withMessage: message
//        ) { result in
//            switch result {
//            case .success:
//                print("Custom message sent!")
//            case .error:
//                print("Couldn't send custom message")
//            }
//        }
        
//        let messagesToDelete = ["475E0410-5FDB-4919-B266-B781FE81B998", "890462D7-ACE8-4607-AA8E-881E3F520C16"]
//
//        appDelegate.mitter.messaging.deleteMessagesFromChannel(
//            fromChannel: "rakfT-XPdJb-WsucS-Pxy4B",
//            messageIds: messagesToDelete
//        ) { result in
//            switch result {
//            case .success:
//                print("Messages deleted!")
//            case .error:
//                print("Couldn't delete messages")
//            }
//        }
    }
}
