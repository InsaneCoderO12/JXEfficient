#
# Be sure to run `pod lib lint JXKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JXKit'
  s.version          = '0.1.73'
  s.summary          = 'A short description of JXKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/augsun'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderSun' => 'codersun@126.com' }
  s.source           = { :git => 'git@gitee.com:codersun/JXKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JXKit/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'JXKit' => ['JXKit/Assets/*.png']
  # }

  s.public_header_files = 'JXKit/Classes/**/*.h'
  #s.vendored_frameworks = 'JXKit/Frameworks/**/*.framework'
  s.frameworks = 'UIKit', 'Foundation', 'AssetsLibrary', 'Security', 'CoreLocation'
  

  
end
