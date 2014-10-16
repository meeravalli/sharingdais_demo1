Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development?
  		provider :facebook, '1472848959663464', '4c84446c2e947eae9dd349ef630b474e', {:provider_ignores_state => true}
  		provider :google_oauth2, '573011007380-ccl5uk12ivu2h8s102r2hf4b3tkah08j.apps.googleusercontent.com', 'iILALYPrIYsBtEnRkOLLwCet'
    else
    	provider :facebook, '1472848959663464', '4c84446c2e947eae9dd349ef630b474e', {:provider_ignores_state => true}
    	provider :google_oauth2, '573011007380-ccl5uk12ivu2h8s102r2hf4b3tkah08j.apps.googleusercontent.com', 'iILALYPrIYsBtEnRkOLLwCet'
    end  
end