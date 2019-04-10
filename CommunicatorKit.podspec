#
# Be sure to run `pod lib lint CommunicatorKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CommunicatorKit'
  s.version          = '0.1.0'
  s.summary          = 'A framework for managing WatchConnectivity communication between phone and watch.'
  s.description      = <<-DESC
A framework for managing WatchConnectivity communication between phone and watch. Should be considered experimental for now, although one app has already been shipped with it. Define message objects that conform to the TransferMessage protocol, and ask Communicator to send them. Define a message-handling class that conforms to the MessageHandler protocol, and Communicator will defer to that class whenever messages come in. Optionally define a class that conforms to the CommunicatorErrorDelegate protocol, and Communicator will pass errors to that class.
                       DESC

  s.homepage         = 'https://github.com/UberJason/CommunicatorKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jason Ji' => 'uberjason@gmail.com' }
  s.source           = { :git => 'https://github.com/UberJason/CommunicatorKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/UberJason'

  s.ios.deployment_target = '11.0'
  s.watchos.deployment_target = '4.0'

  s.source_files = 'CommunicatorKit/Source/**/*'

  s.swift_version = '5.0'

end
