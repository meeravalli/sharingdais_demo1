Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development?
  		provider :facebook, '305002082996204', '5d276bcf8013f4b9d74171cfe800c9d8', {:provider_ignores_state => true}
  		provider :google_oauth2, '573011007380-ccl5uk12ivu2h8s102r2hf4b3tkah08j.apps.googleusercontent.com', 'iILALYPrIYsBtEnRkOLLwCet'
    else
    	provider :facebook, '367201560100241', '0d153a4436d9b3cb290bb8f7cd780489', {:provider_ignores_state => true}
    	provider :google_oauth2, '573011007380-ccl5uk12ivu2h8s102r2hf4b3tkah08j.apps.googleusercontent.com', 'iILALYPrIYsBtEnRkOLLwCet'
    end  
end