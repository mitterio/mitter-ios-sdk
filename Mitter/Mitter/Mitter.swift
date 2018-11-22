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
    public var users = Users()
    public var messaging = Messaging()
    
    let libDefaults: LibDefaults
    
    private var applicationId: String
    private var userId: String = ""
    private var userAuthToken: AuthToken = AuthToken()
    
    private let userApiContainer: UserApiContainer
    private let messageApiContainer: MessageApiContainer
    
    public init(applicationId: String, userAuthToken: String = "") {
        self.applicationId = applicationId
        
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
        
        messageApiContainer = MessageApiContainer(
            applicationId: self.applicationId,
            userAuthToken: self.userAuthToken.signedToken
        )
        
        let jwt = try? decode(jwt: self.userAuthToken.signedToken)
        userId = "\(jwt?.body["userId"] ?? "")"
        setUserId(userId)
        
        users.mitter = self
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
    
    public class Users {
        public typealias userApiResult = (ApiResult<User>) -> Void
        public typealias userPresenceApiResult = (ApiResult<Presence>) -> Void
        
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
        
        public func getUserPresence(userId: String, completion: @escaping userPresenceApiResult) {
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
            getUserPresence(userId: mitter.getUserId(), completion: completion)
        }
    }
    
    public class Messaging {
        weak var mitter: Mitter!
        
        init() {}
        
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
    }
}
