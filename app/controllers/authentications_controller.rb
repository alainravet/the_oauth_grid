class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    if current_user
      omniauth = request.env["omniauth.auth"].except(:extra)
      auth = current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      auth.login  = omniauth.info.nickname
      auth.secret = omniauth.credentials.secret
      auth.token  = omniauth.credentials.token
      auth.save!

      redirect_to root_path, :notice => "Authentication successful."
    else
      redirect_to root_path, :error => "current_user is unknown; You must login locally first."
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to root_path, :notice => "Successfully destroyed authentication."
  end

end

__END__
FOR TWITTER :
  raise omniauth.credentials.to_yaml
  =>
    --- !map:Hashie::Mash
    secret: g66Lj5eBNFYYRVoSGx6ikBpBLBpQ8uEvg1OEq3Awdus
    token: 5910872-otkm1UYzxiVtaIb1ieH9TVY9Cf94jblXbQC4SM5jQ
