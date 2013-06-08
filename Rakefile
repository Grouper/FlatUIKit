desc 'Run the FUIKit tests for iOS'
task :prepare do
  system(%Q{mkdir -p "Tests/FUIKitTests.xcodeproj/xcshareddata/xcschemes" && cp Tests/Schemes/*.xcscheme "Tests/FUIKitTests.xcodeproj/xcshareddata/xcschemes/"})
end

task :ios => :prepare do
  $test_success = system('xctool -workspace Tests/FUIKitTests.xcworkspace -scheme FUIKitTests build -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO')
  $test_success = system('xctool -workspace Tests/FUIKitTests.xcworkspace -scheme FUIKitTests build-tests -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO')
  $test_success = system('xctool -workspace Tests/FUIKitTests.xcworkspace -scheme FUIKitTests test -test-sdk iphonesimulator ONLY_ACTIVE_ARCH=NO')
end

task :test => :ios do
  if $test_success
    puts '** All tests passed successfully **'
  else
    puts 'Unit tests failed'
    exit(-1)
  end
end

task :default => 'test'
