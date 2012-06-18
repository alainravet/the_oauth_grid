class CredentialsController < ApplicationController

  def check
    authentication  = Authentication.find(params[:authentication_id])

    check_credentials(authentication)

    redirect_to root_path
  end

private

  def check_credentials(authentication)
    provider  = authentication.provider
    nickname  = "@#{authentication.login}"

    case CredentialsChecker.check_credentials(authentication)
      when true
        flash[:notice] = "#{nickname} Your #{provider.titleize} credentials are valid"

      when false
        authentication.delete
        flash[:error ] = "#{nickname} - ERROR - Your #{provider.titleize} credentials are invalid. [Login] to get new ones."

      else
        flash[:error ] = "#{nickname} - ERROR - #{provider.titleize} / #{e}"
    end
  end

end
