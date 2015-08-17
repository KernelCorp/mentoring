class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  def forem_name
    email
  end
end
