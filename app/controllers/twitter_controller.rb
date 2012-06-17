class TwitterController < ApplicationController

  def check_credentials
    @authentication = Authentication.find(params[:authentication_id])

    Twitter.configure do |config|
      config.consumer_key     = CREDENTIALS_STORE['twitter']['consumer_key'   ]
      config.consumer_secret  = CREDENTIALS_STORE['twitter']['consumer_secret']
      config.oauth_token        = @authentication.token
      config.oauth_token_secret = @authentication.secret
    end

    begin
      Twitter.verify_credentials
      flash[:notice] = 'Your Twitter credentials are valid'

    rescue Twitter::Error::Unauthorized => e
      @authentication.delete  # remove invalid credentials from DB
      flash[:error] = 'Error : Your Twitter credentials are invalid'
    end

    redirect_to root_path, :error => 'Error : Your Twitter credentials are invalid'
  end

end
