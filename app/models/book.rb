class Book < ActiveRecord::Base
  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_attached_file :file
  enum priority: [ :immediately_read, :must_read, :interesting ]

  validates :name, presence: true

end
