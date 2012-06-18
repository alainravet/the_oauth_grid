
CREDENTIALS_STORE = Hashie::Mash.new(YAML.load(File.open(File.dirname(__FILE__) + '/../credentials.yml'))[Rails.env])
# thx to Hashie::Mash, those calls are equivalent :
#   CREDENTIALS_STORE['twitter']['consumer_secret']
#   CREDENTIALS_STORE.twitter.consumer_secret
#   CREDENTIALS_STORE['twitter'].consumer_secret
#   CREDENTIALS_STORE.twitter['consumer_secret']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  CREDENTIALS_STORE.twitter .consumer_key, CREDENTIALS_STORE.twitter .consumer_secret
  provider :facebook, CREDENTIALS_STORE.facebook.consumer_key, CREDENTIALS_STORE.facebook.consumer_secret,
           :scope => 'email,user_birthday,read_stream'
  provider :linkedin, CREDENTIALS_STORE.linkedin.consumer_key, CREDENTIALS_STORE.linkedin.consumer_secret
end