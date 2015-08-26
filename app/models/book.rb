class Book < ActiveRecord::Base
  enum priority: [ :immediately_read, :must_read, :interesting ]

  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_many :comments, as: :commentable

  has_attached_file :file
  validates_attachment_size :file, less_than: 40.megabytes
  do_not_validate_attachment_file_type :file
  validates :name, presence: true

end
