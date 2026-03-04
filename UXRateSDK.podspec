Pod::Spec.new do |s|
  s.name             = 'UXRateSDK'
  s.version          = '0.1.1'
  s.summary          = 'AI-powered in-app survey SDK for iOS'
  s.homepage         = 'https://github.com/SVUG-Tech/UXRateSDK'
  s.license          = { :type => 'Proprietary', :text => 'Copyright UXRate. All rights reserved.' }
  s.author           = { 'UXRate' => 'sdk@uxrate.app' }

  s.source           = {
    :http => 'https://github.com/SVUG-Tech/UXRateSDK/releases/download/#{s.version}/UXRateSDK.xcframework.zip'
  }

  s.ios.deployment_target = '17.0'
  s.swift_version    = '5.9'

  s.vendored_frameworks = 'UXRateSDK.xcframework'
end
