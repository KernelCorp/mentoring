class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable
end
