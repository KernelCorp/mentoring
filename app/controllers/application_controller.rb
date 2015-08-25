class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :forem_user, :mailbox

  def forem_user
    current_user
  end

  def mailbox
    current_user.mailbox
  end

  private
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_path, :alert => exception.message
    end
end
