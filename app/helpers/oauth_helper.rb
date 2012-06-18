module OauthHelper

  def authorize_access_path(provider)
    "auth/#{provider}"
  end

private

  APP_MANAGER_URLS = {
      :twitter  => 'https://dev.twitter.com/apps/%s/show',
      :facebook => 'https://developers.facebook.com/apps/%s'
  }

  REVOKE_ACCESS_URLS = {
      :twitter  => 'https://twitter.com/settings/applications',
      :facebook => 'https://www.facebook.com/settings?tab=applications'
  }

end