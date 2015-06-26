Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development?
  		provider :facebook, '297568747083890', '62cf2e52043a1e460338407c67a0a50d', {:provider_ignores_state => true}
  		provider :google_oauth2, '573011007380-uq3h0ehr8rsdbfa2l8g1vh6p17jesgtf.apps.googleusercontent.com', 'TKktZ0W2VywvQSkTNN8Hh2kE'
    else
    	provider :facebook, '1472848959663464', '4c84446c2e947eae9dd349ef630b474e', {:provider_ignores_state => true}
    	provider :google_oauth2, '573011007380-uq3h0ehr8rsdbfa2l8g1vh6p17jesgtf.apps.googleusercontent.com', 'TKktZ0W2VywvQSkTNN8Hh2kE'
    end  
end