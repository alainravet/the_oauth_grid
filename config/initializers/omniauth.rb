
CREDENTIALS_STORE = YAML.load(File.open(File.dirname(__FILE__) + '/../credentials.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  CREDENTIALS_STORE['twitter' ]['consumer_key'], CREDENTIALS_STORE['twitter' ]['consumer_secret']
  provider :facebook, CREDENTIALS_STORE['facebook']['consumer_key'], CREDENTIALS_STORE['facebook']['consumer_secret'],
           :scope => 'email,user_birthday,read_stream'

end