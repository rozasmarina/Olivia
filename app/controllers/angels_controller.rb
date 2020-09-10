class AngelsController < ApplicationController
  around_action :catch_not_found
  before_action :set_angel, only: [:edit, :update, :destroy]

  # def index
  #   @angels = policy_scope(Angel).order(created_at: :desc)
  # end

  def new
    @angel = Angel.new
    authorize @angel
  end

  def create
    @angel = Angel.new(angel_params)
    @angel.user = current_user
    authorize @angel
    if @angel.save
      redirect_to users_path
    else
      render :new
    end
  end

  # def show
  #   @angel = Angel.find(params[:id])
  #   authorize @angel
  # end

  def edit
    # realizar a edicao do angel se for current_user
  end

  def update
    if @angel.update(angel_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @angel.destroy
    redirect_to users_path
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :error => "Não encontrado"
    return
  end

  def angel_params
    params.require(:angel).permit(
      :first_name,
      :last_name,
      :phone_number,
      :email
    )
  end

  def set_angel
    @angel = Angel.find(params[:id])
    authorize @angel
  end

end
