class AngelsController < ApplicationController
  def new
    @angel = Angel.new
    authorize @angel
  end

  def create
    @angel = Angel.new(angel_params)
    @angel.user = current_user
    authorize @angel
    if @angel.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def angel_params
    params.require(:angel).permit(
      :first_name,
      :last_name,
      :phone_number,
      :email
    )
  end
end
