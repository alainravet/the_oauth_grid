class FacebookController < ApplicationController

  def check_credentials
    store = CREDENTIALS_STORE['facebook']

    authentication = Authentication.find(params[:authentication_id])
    nickname = authentication.login

    begin
      fb_client  = Koala::Facebook::OAuth.new(store.consumer_key, store.consumer_secret)
      info  = fb_client.exchange_access_token_info(authentication.token)
      flash[:notice] = "@#{nickname} Your Facebook credentials are valid"
      #raise info.to_yaml

    rescue Koala::Facebook::APIError => e
      #OAuthException: Error validating access token: User 100003499485259 has not authorized application 322489727825814.
      if e.message.start_with? 'OAuthException: Error validating access token'
        authentication.delete
        flash[:error] = "@#{nickname} - ERROR -Your Facebook credentials are invalid"
      else
        flash[:error] = "@#{nickname} Error : #{e.message}"
      end
    end

    redirect_to root_path
  end
end
