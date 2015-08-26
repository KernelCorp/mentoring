class Orphanage < ActiveRecord::Base
  has_many :children, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
