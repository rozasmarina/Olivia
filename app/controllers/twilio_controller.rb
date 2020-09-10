require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_and_position, except: %i[voice]
  before_action :set_twilio_client, only: %i[demo_notification]

  def message_angels
    authorize @user, :message_angels?
    redirect_to users_path, notice: 'Você precisa adicionar anjos primeiro.' if @user.angels.length.zero?
    @user.angels.each do |angel|
      puts "Mensagem enviada para #{angel.first_name}:"
      puts "#{@user.message_angels unless @user.message_angels.nil?} #{@message}"
    end
    redirect_to ollivia_path, notice: 'Notificação enviada com sucesso.'
  end

  def message_near_users
    authorize @user, :message_near_users?
    @near_users = User.near(@user, 2)
    @near_users.each do |near_users|
      puts "Mensagem enviada para #{near_users.first_name}:"
      puts "#{@user.message_near_users unless @user.message_near_users.nil?} #{@message}"
    end
    redirect_to ollivia_path, notice: 'Usuárias próximas notificadas.'
  end

  def message_authorities
    authorize @user, :message_authorities?
    puts "Mensagem enviada à polícia:"
    puts "#{@user.message_authorities unless @user.message_authorities.nil?} #{@message}"
    puts "Mensagem enviada à delegacia de mulheres:"

    redirect_to ollivia_path, notice: 'As autoridades foram notificadas.'
  end

  # para usar na demo
  # editar a mensagem

  def demo_notification
    authorize @user, :message_angels?
    @user.angels.each do |angel|
      @client.messages.create(
        from: @twilio_phone,
        to: "+#{angel.phone_number}",
        body: "#{angel.first_name}! #{@message}"
      )
    end
    redirect_to ollivia_path, notice: 'Mensagens enviadas com sucesso.'
  end

  private

  def set_user_and_position
    @user = current_user
    @position = @user.address.split(', ')
    @coords = "#{@user.latitude.round(6)}, #{@user.longitude.round(6)}"
    @message = "#{@user.first_name} #{@user.last_name} precisa de ajuda! Local: #{@position[0]} (#{@position[1]}/#{@position[2]}) - #{@position[3]}. Nas coordenadas: #{@coords}. Enviado via Ollivia."
  end

  def set_twilio_client
    account_sid = ENV['ACC_SID']
    auth_token = ENV['TWILIO_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @twilio_phone = '+12055831356'
  end
end

# método para webhook com resposta por voz
# def voice
#   response = Twilio::TwiML::Response.new do |r|
#     r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', voice: 'alice'
#     r.Play 'http://linode.rabasa.com/cantina.mp3'
#   end

#   render_twiml response
# end

# método para enviar sms
# por ser trial, só funciona com números verificados

# def send_message
#   account_sid = ENV['ACC_SID']
#   auth_token = ENV['TWILIO_TOKEN']
#   client = Twilio::REST::Client.new(account_sid, auth_token)

#   twilio_phone = '+12055831356'
#   to = '+5511974142345'

#   authorize @user, :send_message?
#   client.messages.create(
#     from: twilio_phone,
#     to: to,
#     body: "Hey friend!"
#   )
#   redirect_to ollivia_path, notice: 'Mensagem enviada com sucesso.'
# end
