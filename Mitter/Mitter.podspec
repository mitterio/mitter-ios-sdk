#
#  Be sure to run `pod spec lint Mitter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "Mitter"
  s.version      = "0.0.1"
  s.summary      = "Official iOS SDK for the Mitter messaging platform."
  s.description  = <<-DESC
  Official iOS SDK for using the Mitter messaging platform in iOS apps and build apps around messaging.
                   DESC
  s.homepage     = "https://git.mitter.io/mitter-io/mitter-sdk-ios"
  s.license      = "MIT"
  s.author             = { "Rahul Chowdhury" => "contact@mitter.io" }
  s.social_media_url   = "http://twitter.com/mitter_io"
  s.platform     = :ios
  s.source       = { :git => "URL", :tag => "#{s.version}" }
  s.source_files  = "Mitter", "Mitter/**/*.{h,m,swift}"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "RxSwift", "~> 4.0"
  s.dependency "Moya/RxSwift", "~> 11.0"
  s.dependency "Moya-ModelMapper/RxSwift", "~> 7.1.0"
  s.dependency "Alamofire", "~> 4.7"
  s.dependency "RxCocoa", "~> 4.0"
  s.dependency "PhoneNumberKit", "~> 2.5"
  s.dependency "Swinject", "~> 2.5.0"
  s.dependency "JWTDecode", "~> 2.1"


end
