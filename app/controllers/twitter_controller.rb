class TwitterController < ApplicationController

  def get_private_info
    @authentication = Authentication.find(params[:authentication_id])

    Twitter.configure do |config|
      config.consumer_key     = CREDENTIALS_STORE['twitter']['consumer_key'   ]
      config.consumer_secret  = CREDENTIALS_STORE['twitter']['consumer_secret']
      config.oauth_token        = @authentication.token
      config.oauth_token_secret = @authentication.secret
    end

    @verify_credentials = Twitter.verify_credentials
  end

end
