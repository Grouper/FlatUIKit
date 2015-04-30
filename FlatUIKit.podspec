Pod::Spec.new do |s|
  s.name         = "FlatUIKit"
  s.version      = "1.6.1"
  s.summary      = "A collection of awesome flat UI components for iOS."
  s.homepage     = "https://github.com/Grouper/FlatUIKit"
  s.license      = 'MIT'
  s.authors      = { "Jamie Matthews" => "jmatthews08@gmail.com" }
  s.source       = { :git => "https://github.com/Grouper/FlatUIKit.git", :tag => "1.6.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'

  s.resources    = "Resources/*"
  s.frameworks   = 'QuartzCore', 'CoreText'
  s.requires_arc = true
end
