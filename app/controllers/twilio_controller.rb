require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_and_position, except: %i[voice]

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', voice: 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end

    render_twiml response
  end

  # método para enviar sms
  # por ser trial, só funciona com números verificados
  def send_message
    account_sid = ENV['ACC_SID']
    auth_token = ENV['TWILIO_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    twilio_phone = '+12055831356'
    to = '+5511974142345'

    authorize @user, :send_message?
    client.messages.create(
      from: twilio_phone,
      to: to,
      body: "Hey friend!"
    )
    flash.notice = "Mensagem enviada com sucesso."
    redirect_to ollivia_path
  end
end

def message_angels
end

def message_near_users
end

def message_authorities
end

private

def set_user_and_position
  @user = current_user
  @position = @user.address.split(', ')
  @coords = "#{@user.latitude.round(6)}, #{@user.longitude.round(6)}"
end

# mudar a policy para autorizar o redict
# criar uma coluna de mensagem para user
# adicionar as informações de address no sms
# authorize @user, :show?
# "Preciso de ajuda perto da #{@position[0]}, na #{@position[1]} (#{@position[2]}) em #{@position[3]}. Nas coordenadas: #{@coords}"
