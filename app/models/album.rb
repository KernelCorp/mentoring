# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  validates :user, presence: true
  validates :title, presence: true

end
