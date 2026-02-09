#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_plugin_ic_nfc.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_plugin_ic_nfc'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tran Van Be' => 'be@vnptit.vn' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'OpenSSL-Universal', '~> 3.3.3001'
  s.platform = :ios, '13.0'

  s.vendored_frameworks = 'SDK/ICNFCCardReader.xcframework'
  s.preserve_paths = 'SDK/ICNFCCardReader.xcframework/**/*'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
  }
  
  s.swift_version = '5.0'
end