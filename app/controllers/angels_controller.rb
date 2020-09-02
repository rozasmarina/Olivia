class AngelsController < ApplicationController

  def index
    @angels = policy_scope(Angel).order(created_at: :desc)
  end

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

  def show
    @angel = Angel.find(params[:id])
    authorize @angel
  end

  def edit
    # realizar a edicao do angel se for current_user
    @angel = Angel.find(params[:id])
    authorize @angel
  end

  def update
    @angel = Angel.find(params[:id])
    authorize @angel
    @angel.update(angel_params)
    redirect_to @angel
  end

  def destroy
    @angel = Angel.find(params[:id])
    authorize @angel
    @angel.destroy
    redirect_to @angel
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
