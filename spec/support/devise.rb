module Devise
  module ControllerMacros
    def login_user(user = nil)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = user || FactoryGirl.create(:user)
      sign_in @user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::ControllerMacros, type: :controller
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
