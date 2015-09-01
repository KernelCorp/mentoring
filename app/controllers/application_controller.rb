class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :forem_user, :mailbox, :unread_mails_count, :children_for_friendship

  def forem_user
    current_user
  end

  def mailbox
    current_user.mailbox
  end

  def unread_mails_count
    #mailbox.inbox(unread: true).count
    mailbox.receipts(is_read: false).count
  end

  def children_for_friendship
    if user_signed_in?
      Child.accessible_by(current_ability).want_to_be_friends.order(id: :asc)
    else
      []
    end
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
