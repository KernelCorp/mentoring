class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    render(:file => File.join(Rails.root, 'public/404.html'), :status => 404)
  end

  def forem_user
    current_user
  end
  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
