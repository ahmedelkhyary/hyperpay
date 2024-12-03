#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint payment.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'hyperpay_plugin'
  s.version          = '0.0.3'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://www.gosi.gov.sa'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'GOSI' => 'mradwan1@gosi.gov.sa' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'hyperpay_sdk' , '~> 5.1.0'

 end
