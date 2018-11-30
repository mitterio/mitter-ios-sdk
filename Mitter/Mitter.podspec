Pod::Spec.new do |s|

  s.name         = "Mitter"
  s.version      = "0.0.2"
  s.summary      = "Official iOS SDK for the Mitter messaging platform."
  s.description  = <<-DESC
  Official iOS SDK for using the Mitter messaging platform in iOS apps and build apps around messaging.
                   DESC
  s.homepage     = "https://git.mitter.io/mitter-io/mitter-sdk-ios"
  s.license      = "Apache-2.0"
  s.author             = { "Rahul Chowdhury" => "contact@mitter.io" }
  s.social_media_url   = "http://twitter.com/mitter_io"
  s.platform = :ios, "9.0"
  s.source       = { :git => "https://github.com/mitterio/mitter-ios-sdk.git", :tag => "#{s.version}" }
  s.source_files  = "Mitter", "Mitter/**/*.{h,m,swift}"

  s.dependency "RxSwift", "~> 4.0"
  s.dependency "Moya/RxSwift", "~> 11.0"
  s.dependency "Moya-ModelMapper/RxSwift", "~> 7.1.0"
  s.dependency "Alamofire", "~> 4.7"
  s.dependency "RxCocoa", "~> 4.0"
  s.dependency "PhoneNumberKit", "~> 2.5"
  s.dependency "Swinject", "~> 2.5.0"
  s.dependency "JWTDecode", "~> 2.1"

end
