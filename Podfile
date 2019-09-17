platform :ios, '10.0'

workspace 'Transformers.xcworkspace'

def service_manager_pods
    	pod 'Locksmith'
      pod 'Alamofire'
      pod 'SwiftLint'
end

def transformers_pods

      pod 'R.swift'
      pod 'SwiftLint'

end

target 'Transformers' do
      use_frameworks!
      inhibit_all_warnings!
	
    # Import pods
      service_manager_pods
      transformers_pods

      target 'TransformersTests'
      target 'TransformersUITests'
end

target 'ServiceManager' do
    	platform :ios, '10.0'
    	use_frameworks!
    	inhibit_all_warnings!
    
    	service_manager_pods

      target 'ServiceManagerTests'
    
    	project 'ServiceManager/ServiceManager'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        plist_buddy = "/usr/libexec/PlistBuddy"
        plist = "Pods/Target Support Files/#{target}/Info.plist"
        
        puts "Add arm64 to #{target} to make it pass iTC verification."
        
        `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities array" "#{plist}"`
        `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities:0 string arm64" "#{plist}"`
    end
end
