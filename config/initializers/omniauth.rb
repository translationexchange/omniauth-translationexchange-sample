OAUTH_CLIENT_ID = 'bf411e6aa3baf972ca054c3d353133e6dcaca75c28fe31d4476b22195c04eca3'
OAUTH_CLIENT_SECRET = 'ccdbfb73ccb25f0771075a8a4cfdf8a2a2954b11cde8565b6ab63be4b42a7eeb'
OAUTH_CLIENT_URL = 'http://localhost:3008'

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :translationexchange, OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET
end
