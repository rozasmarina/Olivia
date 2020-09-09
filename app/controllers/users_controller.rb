class UsersController < ApplicationController
  def show
    @user = current_user
    @places = Place.where(owner: nil)
    authorize @user
  end

  def update_position
    @user = current_user
    authorize @user
    @user.latitude = params[:lat].to_f
    @user.longitude = params[:lng].to_f
    @user.save
  end

  # def update_messages
  #   @user = current_user
  #   authorize @user
  #   if params[:message][:message_angels]
  #     @user.message_angels = params[:message][:message_angels]
  #   elsif params[:message][:message_near_users]
  #     @user.message_near_users = params[:message][:message_near_users]
  #   else
  #     @user.message_authorities = params[:message][:message_authorities]
  #   end
  #   @user.save ? (redirect_to users_path) : (render :show)
  # end

  def edit_messages
    @user = current_user
    authorize @user
  end

  # ! DO NOT DELETE
  # def sos_angels
  #   #Precisamos criar uma função que transforme lat e lng em endereço e chamamos na variável abaixo
  #   sos_address = '????'
  #   client = Twilio::REST::Client.new
  #   current_user.angels.each do |a|
  #     client.messages.create({
  #       from: ENV['TWILIO_PHONE'],
  #       to: a.phone_number,
  #       #precisamos inserir em body o endereço que pegamos em sos_address
  #       body: "Oi, aqui é #{current._user.first_name} #{current._user.last_name} "
  #     })
  #   end
  # end
end
