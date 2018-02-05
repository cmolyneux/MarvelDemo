platform :ios, '9.0'

target 'MarvelDemo' do
  use_frameworks!

	plugin 'cocoapods-keys', {
 	   :project => "Marvel",
   	 :keys => [
  	    "MarvelApiKey",
    	  "MarvelPrivateKey"
   	 ]}
	

  # Pods for MarvelDemo
  pod 'CryptoSwift'
  pod 'Alamofire'
  pod 'AlamofireImage'

  target 'MarvelDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
