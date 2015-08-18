class Orphanage < ActiveRecord::Base
  has_many :children, dependent: :destroy
end
