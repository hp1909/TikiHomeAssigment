# Uncomment the next line to define a global platform for your project

def testing_pods
  pod 'Nimble'
  pod 'Quick'
  pod 'RxTest', '~> 5'
  pod 'Mockingjay'
end

target 'TikiHomeAssignment' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'
  pod 'AlamofireImage', '~> 3.5'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'

  target 'TikiHomeAssignmentTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'TikiHomeAssignmentUITests' do
    testing_pods
    pod 'KIF-Quick'
  end
end
