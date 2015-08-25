class ApplicationController < ActionController::Base
  helper_method :forem_user, :mailbox

  def forem_user
    current_user
  end

  def mailbox
    current_user.mailbox
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
