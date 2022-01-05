# Uncomment the next line to define a global platform for your project
platform :ios, '13.2'

workspace 'boilerplate-swiftui-bloc.xcworkspace'

target 'boilerplate-swiftui-bloc' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for boilerplate-swiftui-bloc
  
  target 'boilerplate-swiftui-bloc' do
    project 'boilerplate-swiftui-bloc.xcodeproj'
    
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git'
    pod 'SwiftBloc', :git => 'https://github.com/camapblue/SwiftBloc'
    pod 'SwiftUIRefresh', :git => 'https://github.com/timbersoftware/SwiftUIRefresh.git'
  end  

  target 'boilerplate-swiftui-blocTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'MockingbirdFramework', '~> 0.18'
    pod 'SwiftBloc', :git => 'https://github.com/camapblue/SwiftBloc'
  end

  target 'boilerplate-swiftui-blocUITests' do
    # Pods for testing
  end

  target 'RepositoryTests' do
    project 'Repository/Repository.xcodeproj'

    pod 'MockingbirdFramework', '~> 0.18'
  end

end

