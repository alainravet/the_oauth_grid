class TwitterController < ApplicationController

  def check_credentials
    authentication = Authentication.find(params[:authentication_id])

    load_twitter_application_credentials(CREDENTIALS_STORE['twitter'])
    client = twitter_client_with_credentials(authentication)

    nickname = authentication.login

    begin
      client.verify_credentials
      flash[:notice] = "@#{nickname} Your Twitter credentials are valid"

    rescue Twitter::Error::Unauthorized => e
      authentication.delete  # remove invalid credentials from DB
      flash[:error] = "@#{nickname} Error : Your Twitter credentials are invalid. [Login] to get new ones."

    rescue => e # see **1 below
      flash[:error] = "@#{nickname} Unexpected Error : #{e}"
    end

    redirect_to root_path
  end

private

  def load_twitter_application_credentials(store)
    Twitter.configure do |config|
      config.consumer_key     = store.consumer_key
      config.consumer_secret  = store.consumer_secret
    end
  end

  def twitter_client_with_credentials(authentication)
    Twitter::Client.new(:oauth_token => authentication.token, :oauth_token_secret => authentication.secret)
  end

end

__END__

**1 : NETWORK ERROR encountered a few times
  Faraday::Error::ConnectionFailed in TwitterController#check_credentials
    getaddrinfo: nodename nor servname provided, or not known
