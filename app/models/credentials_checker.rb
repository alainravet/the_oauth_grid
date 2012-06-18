class CredentialsChecker


  def self.check_credentials(authentication)
    store     = CREDENTIALS_STORE[authentication.provider]
    provider  = authentication.provider

    send("check_#{provider}_credentials", store, authentication)
  end

private

  def self.check_twitter_credentials(store, authentication)
    begin
      Twitter.configure do |config|
        config.consumer_key    = store.consumer_key
        config.consumer_secret = store.consumer_secret
      end
      client = Twitter::Client.new(:oauth_token => authentication.token, :oauth_token_secret => authentication.secret)
      client.verify_credentials
      true

    rescue Twitter::Error::Unauthorized => e
      false
    rescue => e
      e
    end
  end

  def self.check_facebook_credentials(store, authentication)
    begin
      fb_client  = Koala::Facebook::OAuth.new(store.consumer_key, store.consumer_secret)
      fb_client.exchange_access_token_info(authentication.token)
      true

    rescue Koala::Facebook::APIError => e
      #OAuthException: Error validating access token: User 100003499485259 has not authorized application 322489727825814.
      if e.message.start_with? 'OAuthException: Error validating access token'
        false
      else
        e
      end
    end
  end


end