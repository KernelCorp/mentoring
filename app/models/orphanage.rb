# == Schema Information
#
# Table name: orphanages
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Orphanage < ActiveRecord::Base
  has_many :children, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
