Pod::Spec.new do |s|
  s.name             = "NSString-compareToVersion"
  s.version          = "0.4"
  s.summary          = "An iOS SDK for the Uber API"
  s.homepage         = "https://github.com/stijnster/NSString-compareToVersion"
  s.license          = 'MIT'
  s.author           = { "Stijn Mathysen" => "stijn@skylight.be" }
  s.source           = { :git => "https://github.com/stijnster/NSString-compareToVersion.git", :tag => '0.4' }
  s.platform     = :osx, '10.8'
  s.requires_arc = true
  s.source_files = 'Library/*'
end