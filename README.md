# Getting started for iOS SDK
The iOS SDK for Mitter currently has very basic features like:
* Getting the current user information
* Creating a channel
* Send text messages
* Receive message via FCM (through APNs)

## Installation
The SDK is currently available as a local Cocoapod and can be installed as a regular pod.

If you’re using the Mitter SDK Demo project then just navigate to the Mitter SDK Demo folder in your terminal and run this command:

	pod install

Else, if you’re starting with a fresh project, create a `Podfile` in your new project and add the following dependencies:

	pod ‘Mitter’

Before that, make sure you’ve Cocoapods [installed and setup](https://guides.cocoapods.org/using/using-cocoapods) for your project.

Then just navigate to your new project and run:

	pod install

## Basic setup
Before you can start communicating with Mitter using the SDK, it needs to be configured with your **application ID** and **user auth token ID**.

The best place to configure a global `Mitter` object is inside your `AppDelegate.swift` file.

Open up the `AppDelegate` file and declare an instance field for the `Mitter` object, like this:

	var mitter: Mitter = Mitter(applicationId: "")

After you’ve done that, locate the function with `didFinishLaunchingWithOptions` signature and initialise your `Mitter` object with your application and user details like this:

	mitter = Mitter(
	            applicationId: "MZzf4-na9nL-O98wq-M1HxS",
	            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6IkhYbkZJSXIydUpQRHMzankiLCJ1c2VydG9rZW4iOiJhaHFtNTgzcjRwbzEwZmNqZTllaHE5dDV1NCIsImFwcGxpY2F0aW9uSWQiOiJNWnpmNC1uYTluTC1POTh3cS1NMUh4UyIsInVzZXJJZCI6ImNzckN5LVNKTDN1LThBS01ULVdxdjZ5In0.FTgn0GBgIQrA0NznQEUHyC7SN7rbN9O9cWlI5mejuDG466VSJHjwGWZF2DB3nsn8eoeCg5toIXXh5Sxz2MMU3w"
	)

The user token is enough to help the SDK figure out the user ID. Therefore, you don’t need to explicitly add the user ID.

## Get the current user details
Now, go to your main `ViewController` which is the `ViewController.swift` file under your project.

Inside the `viewDidLoad()` function, get a reference to your `AppDelegate` instance by adding the following line:

	let appDelegate = UIApplication.shared.delegate as! AppDelegate

Now, you can easily make a call to Mitter and see the currently authenticated user details by calling the `getCurrentUsers()` function on the `Mitter.Users` object.

This can be done like this:

	                appDelegate.mitter.users.getCurrentUser {
	                    result in
	                    switch result {
	                    case .success(let user):
	                        print("Current User is: \(user)")
	                    case .error:
	                        print("Unable to get user!")
	                    }
	                }
	

Now, press `⌘R` to run your project in any iPhone simulator.

If everything’s setup according to the previous steps, you should be able to see the currently authenticated user details printed to your console log inside Xcode.

## Create a channel
To create a new channel using the SDK, you need to create at least 2 `Participant` instances with the participant user IDs and pass them as an array to either to `createDirectMessageChannel()` or `createGroupMessageChannel()` function depending on the number of participants you have.

Let’s initialise two participants and create a direct message channel.

	let stan = Participant(id: "csrCy-SJL3u-8AKMT-Wqv6y")
	let rahul = Participant(id: "E3CAM-jjw8A-WeqDe-cWFe7")

Substitute the user IDs with your own user IDs here.

Now, call the function:

	appDelegate.mitter.channels.createGroupMessageChannel(participants: [stan, rahul]) { result in
	            switch result {
	            case .success(let channelId):
	                print("New channel created: \(channelId)")
	            case .error:
	                print("Couldn't create channel")
	            }
	        }

Run your project and now you should see a _New channel created_ message in your console log along with the ID of the newly created channel.

Note down the ID because we’ll use it to send and receive some messages.

## Send a plain text message
Sending a plain text message is really simple. Just call the `sendTextMessage()` function on the `Mitter.Messaging` instance and pass a channel ID and text payload.

	                appDelegate.mitter.messaging.sendTextMessage(
	                    forChannel: "rakfT-XPdJb-WsucS-Pxy4B",
	                    "Hello from iOS!"
	                ) { result in
	                    switch result {
	                    case .success:
	                        print("Message sent!")
	                    case .error:
	                        print("Couldn't send message")
	                    }
	                } 

Here you can specify the channel ID that you got while creating a new channel in the previous step.

Run the project and it should send out a new message to the channel.

## Get messages in a channel
You can get messages sent to a particular channel by calling the `getMessagesInChannel()` and passing in the channel ID:

	appDelegate.mitter.messaging.getMessagesInChannel("rakfT-XPdJb-WsucS-Pxy4B") {
	            result in
	            switch result {
	            case .success(let messages):
	                print("Messages: \(messages)")
	            case .error:
	                print("Couldn't fetch messages")
	            }
	        }

Run the project and you should be getting a list of messages printed to your console log.

## Receive push messages from FCM
Before you can start receiving messages through FCM, you need to setup FCM in your project.

Firebase has a pretty comprehensive tutorial for setting up FCM. Follow the steps [over here](https://firebase.google.com/docs/cloud-messaging/ios/client) and you should be ready to receive messages via FCM.

Now that you’ve configured FCM in your project you can hook it up with Mitter using the following steps:

### Register a delivery endpoint
Before receiving any messages from Mitter you need to register the device’s FCM token as a delivery endpoint with Mitter.

You can get and register the FCM token by calling the `registerFcmToken()` function on the `Mitter` object within the function which has the signature of `didRegisterForRemoteNotificationsWithDeviceToken` variable, like this:

	InstanceID.instanceID().instanceID { (result, error) in
	            if let error = error {
	                print("Error fetching remote instange ID: \(error)")
	            } else if let result = result {
	                print("Remote instance ID token: \(result.token)")
	                
	                self.mitter.registerFcmToken(token: result.token) {
	                    result in
	                    switch result {
	                    case .success(let deliveryEndpoint):
	                        print("Endpoint is: \(deliveryEndpoint.serializedEndpoint)")
	                    case .error:
	                        print("Unable to register endpoint!")
	                    }
	                }
	            }
	        }

After that, you need to process incoming FCM messages by forwarding them to Mitter. Look for the function called `userNotificationCenter()` which has the variable named `willPresent` and then get the serialised data dictionary from the FCM notification dictionary, like this:

	let messageString = userInfo["data"] as! String


Next, you need to convert this into a `MessagingPipelinePayload` object. This can be done by passing the serialised dictionary from the previous step, like this:

	let messagingPipelinePayload = mitter.parseFcmMessage(data: messageString)

Now that you have the `MessagingPipelinePayload` object, you can check if the message is from Mitter by calling the function `isMitterMessage()` which returns `Bool`.

Next, you need to process the push message by passing the `MessagingPipelinePayload` object and hooking up the completion handlers, like this:

	if mitter.isMitterMessage(messagingPipelinePayload) {
	            let payload = mitter.processPushMessage(messagingPipelinePayload!)
	            
	            switch payload {
	            case .NewMessagePayload(let message, let channelId):
	                print("Received Message: \(message), for Channel: \(channelId)")
	            default:
	                print("Nothing to print!")
	            }
	        }

Here, `payload` is an enum which has various cases like `NewMessagePayload`, `NewChannelPayload`, etc.

> Do note, for FCM messages to work, you need to run the project in a physical iOS device.

_ Also, you need to include dataType as cloud-notification on any message that choose to send using a direct API call from Postman or any other REST client._

Cheers! 🍻 