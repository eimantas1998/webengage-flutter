require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = pubspec['description']
  s.description      = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Ashwin Dinesh' => 'ashwin.dinesh@webklipper.com' }
  s.source           = { :path => '.' }

  s.source_files = 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/*.h'

  s.dependency 'Flutter'
  s.dependency 'WebEngage', '~> 5.2.8'
  s.platform = :ios, '10.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
end
