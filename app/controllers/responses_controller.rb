class ResponsesController < ApplicationController
  before_action :set_show, only: %i[show]

  def show
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end
end
