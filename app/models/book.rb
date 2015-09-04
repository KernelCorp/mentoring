# == Schema Information
#
# Table name: books
#
#  id                :integer          not null, primary key
#  name              :string
#  priority          :integer          default(2)
#  owner_id          :integer
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Book < ActiveRecord::Base
  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  include PublicActivity::Model
  tracked only: [:create], owner: :owner

  enum priority: [ :immediately_read, :must_read, :interesting ]

  has_attached_file :file
  validates_attachment_size :file, less_than: 40.megabytes
  do_not_validate_attachment_file_type :file

  validates :name, presence: true
  validates :owner, presence: true

end
