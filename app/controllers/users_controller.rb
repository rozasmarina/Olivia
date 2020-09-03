class UsersController < ApplicationController

  def show
    @user = current_user
    authorize @user
  end

  def sos_angels
    #Precisamos criar uma função que transforme lat e lng em endereço e chamamos na variável abaixo
    sos_address = ????
    client = Twilio::REST::Client.new 
    current_user.angels.each do |a|
      client.messages.create({
        from: ENV['TWILIO_PHONE'],
        to: a.phone_number,
        #precisamos inserir em body o endereço que pegamos em sos_address
        body: "Oi, aqui é #{current._user.first_name} #{current._user.last_name} "
      })
    end
  end
end
