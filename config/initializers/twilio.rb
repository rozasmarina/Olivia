Twilio.configure do |config|
  config.account_sid = ENV['ACC_SID']
  config.auth_token = ENV['TWILIO_TOKEN']
end


# client = Twilio::REST::Client.new => controller, antes de iterar com os angels
# - dentro da iteração de angels - 
# client.messages.create({
#   from: ENV['TWILIO_PHONE'],
#   to: "+5511980665313", => angel number
#   body: 'Hello there! This is a test'
# })