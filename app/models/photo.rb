# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  album_id           :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments, as: :commentable
  has_one :child

  has_attached_file :image
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 16.megabytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png image/gif image/bmp)

  validates :user, presence: true

  scope :persisted, -> { where 'id IS NOT NULL' }

end
