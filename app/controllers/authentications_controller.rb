class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    if current_user
      omniauth = request.env["omniauth.auth"].except(:extra)
      auth = current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      auth.login  = extract_login_from_twitter(omniauth)
      auth.secret = extract_secret_from_twitter(omniauth)
      auth.token  = extract_token_from_twitter(omniauth)
      auth.save!

      redirect_to root_path, :notice => "Authentication successful."
    else
      redirect_to root_path, :error => "current_user is unknown; You must login locally first."
    end
  end

  def extract_login_from_twitter(omniauth)
    omniauth.info.nickname
  end

  def extract_token_from_twitter(omniauth)
    omniauth.credentials.token
  end

  def extract_secret_from_twitter(omniauth)
    omniauth.credentials.secret
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to root_path, :notice => "Successfully destroyed authentication."
  end

  def failure
    raise "params == \n" + params.to_yaml
  end
end

__END__
FOR TWITTER :
  raise omniauth.credentials.to_yaml
  =>
    --- !map:Hashie::Mash
    secret: g66Lj5eBNFYYRVoSGx6ikBpBLBpQ8uEvg1OEq3Awdus
    token: 5910872-otkm1UYzxiVtaIb1ieH9TVY9Cf94jblXbQC4SM5jQ
