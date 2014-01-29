Pod::Spec.new do |s|
  s.name         = "FlatUIKit"
  s.version      = "1.3"
  s.summary      = "A collection of awesome flat UI components for iOS."
  s.homepage     = "https://github.com/Grouper/FlatUIKit"
  s.license      = 'MIT'
  s.authors      = { "Jack Flintermann" => "jack@joingrouper.com", "Grouper" => "jobs@joingrouper.com"}
  s.source       = { :git => "https://github.com/Grouper/FlatUIKit.git", :tag => "1.3" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'

  s.resources = "Resources/*"
  s.framework  = 'CoreText'
  s.requires_arc = true
end
