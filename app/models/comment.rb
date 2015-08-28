class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :text, presence: true, length: { in: 3..141 }
  validates :commentable, presence: true
end
