class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: %i[show]
  # before_action :check_user, only: %i[show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user

  def show
    if current_user.provider
      @reminders = WorkList.where(provider_id: current_user.provider.id)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    unless current_user == @user
      redirect_to root_path
    end
  end

  def invalid_user
    # logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, notice: "Invalid user"
  end
  
end
