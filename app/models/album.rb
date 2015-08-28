class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  validates :user, presence: true
  validates :title, presence: true

end
