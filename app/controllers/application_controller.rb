class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :forem_user, :mailbox

  def forem_user
    current_user
  end

  def mailbox
    current_user.mailbox
  end

  def after_sign_in_path_for resource
    if current_user.has_role? :admin
      rails_admin_path
    else
      user_path current_user
    end
  end

  private
    rescue_from CanCan::AccessDenied do |exception|
      if user_signed_in? && can?(:read, current_user)
        redirect_to current_user, alert: exception.message
      else
        redirect_to main_app.root_path
      end
    end
end
