class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments, as: :commentable

  has_attached_file :image
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 16.megabytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png image/gif image/bmp)

  validates :user, presence: true

  scope :persisted, -> { where 'id IS NOT NULL' }

end
