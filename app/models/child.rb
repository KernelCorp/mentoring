# == Schema Information
#
# Table name: children
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  middle_name         :string
#  birthdate           :date
#  orphanage_id        :integer
#  mentor_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  is_friendly         :boolean          default(FALSE)
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Child < ActiveRecord::Base
  belongs_to :orphanage
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User'
  has_many :meetings

  has_attached_file :avatar
  validates_attachment_size :avatar, less_than: 1.megabytes
  validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png image/gif)

  validates :first_name, presence: true
  validates :last_name,  presence: true

  scope :want_to_be_friends, -> { where(is_friendly: true) }

  def name
    first_name
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
