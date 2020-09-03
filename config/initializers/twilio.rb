Twilio.configure do |config|
  config.account_sid = ENV['ACC_SID']
  config.auth_token = ENV['TWILIO_TOKEN']
end
