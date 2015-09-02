class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Аватар успешно сохранён.'
    else
      flash[:notice] = 'Аватар не удалось сохранить.'
      flash[:error] = @user.errors.full_messages.first
    end
    redirect_to @user
  end

  private
    def user_params
      params.require(:user).permit(:avatar)
    end
end
