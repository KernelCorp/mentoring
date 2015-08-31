# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :text, presence: true, length: { in: 3..141 }
  validates :commentable, presence: true
end
