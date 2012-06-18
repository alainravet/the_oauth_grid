module OauthPlusHelper

  def manage_your_social_app_url(provider, app_id)
    APP_MANAGER_URLS[provider.to_sym] % app_id
  end

  def revoke_access_url(provider, app_id)
    REVOKE_ACCESS_URLS[provider.to_sym] % app_id
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