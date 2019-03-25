//
//  Mitter.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 05/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxSwift
import Swinject
import JWTDecode

public class Mitter {
    public static var mitterApiEndpoint: String = Constants.Urls.baseUrl
    public var users = Users()
    public var channels = Channels()
    public var messaging = Messaging()
    
    let libDefaults: LibDefaults
    
    private var applicationId: String
    private var userId: String = ""
    private var userAuthToken: AuthToken = AuthToken()
    
    private let userApiContainer: UserApiContainer
    private let channelApiContainer: ChannelApiContainer
    private let messageApiContainer: MessageApiContainer
    
    public init(
        applicationId: String,
        userAuthToken: String = "",
        mitterApiEndpoint: String = "https://api.mitter.io"
        ) {
        self.applicationId = applicationId
        Mitter.mitterApiEndpoint = mitterApiEndpoint
        
        libDefaults = LibDefaults(applicationId: applicationId)
        
        self.userAuthToken = libDefaults.getToken()
        if self.userAuthToken.signedToken.isEmpty {
            let authToken = AuthToken(id: "", signedToken: userAuthToken)
            self.userAuthToken = authToken
            libDefaults.saveToken(authToken: authToken)
        }
        
        userApiContainer = UserApiContainer(
            applicationId: self.applicationId,
            userAuthToken: self.userAuthToken.signedToken
        )
        
        channelApiContainer = ChannelApiContainer(
            applicationId: self.applicationId,
            userAuthToken: self.userAuthToken.signedToken
        )
        
        messageApiContainer = MessageApiContainer(
            applicationId: self.applicationId,
            userAuthToken: self.userAuthToken.signedToken
        )
        
        let jwt = try? decode(jwt: self.userAuthToken.signedToken)
        userId = "\(jwt?.body["userId"] ?? "")"
        setUserId(userId)
        
        users.mitter = self
        channels.mitter = self
        messaging.mitter = self
    }
    
    public func getUserId() -> String {
        if userId.isEmpty {
            return libDefaults.getUserId()
        }
        
        return userId
    }
    
    public func setUserId(_ userId: String) {
        self.userId = userId
        libDefaults.saveUserId(userId: userId)
    }
    
    public func getUserAuthToken() -> AuthToken {
        if userAuthToken.signedToken.isEmpty {
            return libDefaults.getToken()
        }
        
        return userAuthToken
    }
    
    public func setUserAuthToken(_ userAuthToken: String) {
        self.userAuthToken = AuthToken(id: "", signedToken: userAuthToken)
        libDefaults.saveToken(authToken: self.userAuthToken)
    }
    
    public func registerFcmToken(token: String, completion: @escaping (ApiResult<DeliveryEndpoint>) -> Void) {
        let addFcmDeliveryEndpointAction = userApiContainer.getAddFcmDeliveryEndpointAction()
        
        addFcmDeliveryEndpointAction
            .execute(t1: getUserId(), t2: token)
            .subscribe { event in
                switch event {
                case .success(let deliveryEndpoint):
                    completion(ApiResult.success(deliveryEndpoint))
                case .error(let error):
                    print("Error is: \(error)")
                    completion(ApiResult.error)
                }
        }
    }
    
    public func parseFcmMessage(data: String) -> MessagingPipelinePayload? {
        return userApiContainer.getPushMessageManager().parseFcmMessage(data: data)
    }
    
    public func isMitterMessage(_ messagingPipelinePayload: MessagingPipelinePayload?) -> Bool {
        return userApiContainer.getPushMessageManager().isMitterMessage(messagingPipelinePayload: messagingPipelinePayload)
    }
    
    public func processPushMessage(_ messagingPipelinePayload: MessagingPipelinePayload) -> Payload {
        switch messagingPipelinePayload.type {
        case StandardPipelinePayloadNames.NewChannelPayload:
            return Payload.NewChannelPayload(messagingPipelinePayload.channel!)
        case StandardPipelinePayloadNames.NewMessagePayload:
            return Payload.NewMessagePayload(messagingPipelinePayload.message!, messagingPipelinePayload.channelId!)
        case StandardPipelinePayloadNames.NewChannelTimelineEventPayload:
            return Payload.NewChannelTimelineEventPayload(messagingPipelinePayload.timelineEvent!, messagingPipelinePayload.channelId!)
        case StandardPipelinePayloadNames.NewMessageTimelineEventPayload:
            return Payload.NewMessageTimelineEventPayload(messagingPipelinePayload.timelineEvent!, messagingPipelinePayload.messageId!)
        case StandardPipelinePayloadNames.ParticipationChangedEventPayload:
            return Payload.ParticipationChangedEventPayload(
                messagingPipelinePayload.participantId!,
                messagingPipelinePayload.channelId!,
                messagingPipelinePayload.newStatus!,
                messagingPipelinePayload.oldStatus!
            )
        default:
            return Payload.Empty
        }
    }
    
    public func authenticateGoogleSignIn(_ token: String, completion: @escaping (ApiResult<Empty>) -> Void) {
        let authenticateGoogleSignInAction = userApiContainer.getAuthenticateGoogleSignInAction()
        
        authenticateGoogleSignInAction
            .execute(t: token)
            .subscribe { event in
                switch event {
                case .success(let federatedUserRegistration):
                    self.setUserId(federatedUserRegistration.federatedUser.federatedUserId)
                    self.setUserAuthToken(federatedUserRegistration.autoLoginToken)
                    completion(ApiResult.success(Empty()))
                case .error:
                    completion(ApiResult.error)
                }
        }
    }
    
    public class Users {
        public typealias userApiResult = (ApiResult<User>) -> Void
        public typealias userPresenceApiResult = (ApiResult<Presence>) -> Void
        public typealias emptyApiResult = (ApiResult<Empty>) -> Void
        
        weak var mitter: Mitter!
        
        init() {}
        
        public func getUser(_ userId: String, completion: @escaping userApiResult) {
            let fetchUserAction = mitter.userApiContainer.getFetchUserAction()
            
            fetchUserAction
                .execute(t: userId)
                .subscribe { event in
                    switch event {
                    case .success(let user):
                        completion(ApiResult.success(user))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getCurrentUser(completion: @escaping userApiResult) {
            getUser(mitter.getUserId(), completion: completion)
        }
        
        public func getUserPresence(_ userId: String, completion: @escaping userPresenceApiResult) {
            let fetchUserPresenceAction = mitter.userApiContainer.getFetchUserPresenceAction()
            
            fetchUserPresenceAction
                .execute(t: userId)
                .subscribe { event in
                    switch event {
                    case .success(let userPresence):
                        completion(ApiResult.success(userPresence))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getCurrentUserPresence(completion: @escaping userPresenceApiResult) {
            getUserPresence(mitter.getUserId(), completion: completion)
        }
        
        public func setCurrentUserPresence(_ presence: Presence, completion: @escaping emptyApiResult) {
            let updateUserPresenceAction = mitter.userApiContainer.getUpdateUserPresenceAction()
            
            updateUserPresenceAction
                .execute(t1: mitter.getUserId(), t2: presence)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getUsersByLocators(_ locators: [String], completion: @escaping (ApiResult<[User]>) -> Void) {
            let fetchUsersByLocatorsAction = mitter.userApiContainer.getFetchUsersByLocatorsAction()
            
            fetchUsersByLocatorsAction
                .execute(t: locators)
                .subscribe { event in
                    switch event {
                    case .success(let users):
                        completion(ApiResult.success(users))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
    }
    
    public class Channels {
        public typealias emptyApiResult = (ApiResult<Empty>) -> Void
        public typealias channelIdentifiableApiResult = (ApiResult<Identifiable<Channel>>) -> Void
        public typealias participatedChannelsApiResult = (ApiResult<[ParticipatedChannel]>) -> Void
        
        weak var mitter: Mitter!
        
        init() {}
        
        public func getChannel(_ channelId: String, completion: @escaping (ApiResult<Channel>) -> Void) {
            let fetchChannelAction = mitter.channelApiContainer.getFetchChannelAction()
            
            fetchChannelAction
                .execute(t: channelId)
                .subscribe { event in
                    switch event {
                    case .success(let channel):
                        completion(ApiResult.success(channel))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getChannelsForUser(userId: String, completion: @escaping participatedChannelsApiResult) {
            let fetchChannelsForUserAction = mitter.channelApiContainer.getFetchChannelsForUserAction()
            
            fetchChannelsForUserAction
                .execute(t: userId)
                .subscribe { event in
                    switch event {
                    case .success(let participatedChannels):
                        completion(ApiResult.success(participatedChannels))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getChannelsForCurrentUser(completion: @escaping participatedChannelsApiResult) {
            getChannelsForUser(userId: mitter.getUserId(), completion: completion)
        }
        
        public func getParticipantsForChannel(channelId: String, completion: @escaping (ApiResult<[ChannelParticipation]>) -> Void) {
            let fetchParticipantsForChannelAction = mitter.channelApiContainer.getFetchParticipantsForChannelAction()
            
            fetchParticipantsForChannelAction
                .execute(t: channelId)
                .subscribe { event in
                    switch event {
                    case .success(let channelParticipants):
                        completion(ApiResult.success(channelParticipants))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func createDirectMessageChannel(participants: [Participant], completion: @escaping channelIdentifiableApiResult) {
            let addDirectMessageChannelAction = mitter.channelApiContainer.getAddDirectMessageChannelAction()
            
            addDirectMessageChannelAction
                .execute(t: participants)
                .subscribe { event in
                    switch event {
                    case .success(let identifier):
                        completion(ApiResult.success(identifier))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func createGroupMessageChannel(participants: [Participant], completion: @escaping channelIdentifiableApiResult) {
            let addGroupChatChannelAction = mitter.channelApiContainer.getAddGroupChatChannelAction()
            
            addGroupChatChannelAction
                .execute(t: participants)
                .subscribe { event in
                    switch event {
                    case .success(let identifier):
                        completion(ApiResult.success(identifier))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func createChannel(_ channel: Channel, completion: @escaping channelIdentifiableApiResult) {
            let addChannelAction = mitter.channelApiContainer.getAddChannelAction()
            
            addChannelAction
                .execute(t: channel)
                .subscribe { event in
                    switch event {
                    case .success(let identifier):
                        completion(ApiResult.success(identifier))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func addParticipantToChannel(channelId: String, participant: Participant, completion: @escaping emptyApiResult) {
            let addParticipantToChannelAction = mitter.channelApiContainer.getAddParticipantToChannelAction()
            
            addParticipantToChannelAction
                .execute(t1: channelId, t2: participant)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func removeChannel(_ channelId: String, completion: @escaping emptyApiResult) {
            let removeChannelAction = mitter.channelApiContainer.getRemoveChannelAction()
            
            removeChannelAction
                .execute(t: channelId)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
    }
    
    public class Messaging {
        public typealias emptyApiResult = (ApiResult<Empty>) -> Void
        
        weak var mitter: Mitter!
        
        init() {}
        
        public func getMessagesInChannel(_ channelId: String, completion: @escaping (ApiResult<[Message]>) -> Void) {
            let fetchMessagesInChannelAction = mitter.messageApiContainer.getFetchMessagesInChannelAction()
            
            fetchMessagesInChannelAction
                .execute(t: channelId)
                .subscribe { event in
                    switch event {
                    case .success(let messages):
                        completion(ApiResult.success(messages))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getMessage(_ messageId: String, completion: @escaping (ApiResult<Message>) -> Void) {
            let fetchMessageAction = mitter.messageApiContainer.getFetchMessageAction()
            
            fetchMessageAction
                .execute(t: messageId)
                .subscribe { event in
                    switch event {
                    case .success(let message):
                        completion(ApiResult.success(message))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func getTimelineEvents(
            forChannel channelId: String,
            messageIds: [String],
            filterByEvents eventTypes: [String] = [String](),
            completion: @escaping (ApiResult<[MessageTimelineEvent]>) -> Void
            ) {
            let fetchTimelineEventsAction = mitter.messageApiContainer.getFetchTimelineEventsAction()
            
            fetchTimelineEventsAction
                .execute(t1: channelId, t2: messageIds, t3: eventTypes)
                .subscribe { event in
                    switch event {
                    case .success(let message):
                        completion(ApiResult.success(message))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func sendTextMessage(
            forChannel channelId: String,
            _ message: String,
            withNotificationDetails messageNotification: MessageNotification = getDefaultMessageNotification(),
            completion: @escaping emptyApiResult
            ) {
            let addTextMessageAction = mitter.messageApiContainer.getAddTextMessageAction()
            let textMessage = TextMessage(senderId: mitter.getUserId(), message: message, messageNotification: messageNotification)
            
            addTextMessageAction
                .execute(t1: channelId, t2: textMessage)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func sendImageMessage(
            forChannel channelId: String,
            withCaption caption: String = "",
            image file: URL,
            withNotificationDetails messageNotification: MessageNotification = getDefaultMessageNotification(),
            completion: @escaping emptyApiResult
            ) {
            let addImageMessageAction = mitter.messageApiContainer.getImageMessageAction()
            let imageMessage = ImageMessage(
                senderId: mitter.getUserId(),
                caption: caption,
                messageNotification: messageNotification
            )
            
            addImageMessageAction
                .execute(t1: channelId, t2: imageMessage, t3: file)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func sendFileMessage(
            forChannel channelId: String,
            withMessage message: Message,
            file: URL,
            withNotificationDetails messageNotification: MessageNotification = getDefaultMessageNotification(),
            completion: @escaping emptyApiResult
            ) {
            let addFileMessageAction = mitter.messageApiContainer.getAddFileMessageAction()
            var messageWithNotification = message
            messageWithNotification.messageData.append(messageNotification.toMessageDatum())
            
            addFileMessageAction
                .execute(t1: channelId, t2: messageWithNotification, t3: file)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func sendMessage(
            forChannel channelId: String,
            withMessage message: Message,
            withNotificationDetails messageNotification: MessageNotification = getDefaultMessageNotification(),
            completion: @escaping emptyApiResult
            ) {
            let addMessageAction = mitter.messageApiContainer.getAddMessageAction()
            var messageWithNotification = message
            messageWithNotification.messageData.append(messageNotification.toMessageDatum())
            
            addMessageAction
                .execute(t1: channelId, t2: messageWithNotification)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func addDeliveredTimelineEvent(channelId: String, messageId: String, completion: @escaping emptyApiResult) {
            let addDeliveredTimelineEventAction = mitter.messageApiContainer.getAddDeliveredTimelineEventAction()
            
            addDeliveredTimelineEventAction
                .execute(t1: channelId, t2: messageId, t3: mitter.getUserId())
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func addReadTimelineEvent(channelId: String, messageId: String, completion: @escaping emptyApiResult) {
            let addReadTimelineEventAction = mitter.messageApiContainer.getAddReadTimelineEventAction()
            
            addReadTimelineEventAction
                .execute(t1: channelId, t2: messageId, t3: mitter.getUserId())
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
        
        public func deleteMessagesFromChannel(fromChannel channelId: String, messageIds: [String], completion: @escaping emptyApiResult) {
            let removeMessagesFromChannelAction = mitter.messageApiContainer.getRemoveMessagesFromChannelAction()
            
            removeMessagesFromChannelAction
                .execute(t1: channelId, t2: messageIds)
                .subscribe { event in
                    switch event {
                    case .success(let empty):
                        completion(ApiResult.success(empty))
                    case .error:
                        completion(ApiResult.error)
                    }
            }
        }
    }
}

public func getDefaultMessageNotification() -> MessageNotification {
    return MessageNotification(
        body: "You've got a new message. Tap to open.",
        icon: "none",
        title: "You've got a message!")
}
