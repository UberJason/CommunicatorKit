# CommunicatorKit

[![Version](https://img.shields.io/cocoapods/v/CommunicatorKit.svg?style=flat)](http://cocoapods.org/pods/CommunicatorKit)
[![License](https://img.shields.io/cocoapods/l/CommunicatorKit.svg?style=flat)](http://cocoapods.org/pods/CommunicatorKit)
[![Platform](https://img.shields.io/cocoapods/p/CommunicatorKit.svg?style=flat)](http://cocoapods.org/pods/CommunicatorKit)

A framework for managing WatchConnectivity communication between phone and watch. Should be considered experimental for now, although one app has already been shipped with it. 

## Installation

CommunicatorKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CommunicatorKit"
```

## Usage
### Sending Messages
Define message objects that conform to the `TransferMessage` protocol, and ask Communicator to send them. (If your set of messages is finite and well-known, you can conform an enum to the `TransferMessage` protocol.)


### Handling Incoming Messages
Define a message-handling class that conforms to the `MessageHandler` protocol, pass it to Communicator on initialization, and Communicator will use that class to handle whenever messages come in. 


### Handling Errors
Optionally define a class that conforms to the `CommunicatorErrorDelegate` protocol, and Communicator will pass errors to that class.


### Suggested Usage
One suggested usage pattern is to subclass Communicator on the watchOS and iOS side to handle platform-specific needs, and to use extensions on Communicator itself to handle needs on both platforms. You might also use a singleton Communicator (or Communicator subclass) retained by the AppDelegate / ExtensionDelegate to be able to send messages globally from within your applications.

## Author

Jason Ji, uberjason@gmail.com

## License

CommunicatorKit is available under the MIT license. See the LICENSE file for more info.
