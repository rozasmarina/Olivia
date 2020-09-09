require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    @user = current_user
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
# mudar a policy para autorizar o redict
# criar uma coluna de mensagem para user
# adicionar as informações de address no sms
# authorize @user, :show?
