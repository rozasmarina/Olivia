class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end
