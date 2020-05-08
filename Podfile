# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def movies_pods
  pod 'Alamofire', '~> 5.1'
  pod 'SwiftyJSON', '~> 4.0'
end

target 'movies' do
  movies_pods
  
  target 'moviesTests' do
    inherit! :search_paths
    # Pods for testing
  end
end


