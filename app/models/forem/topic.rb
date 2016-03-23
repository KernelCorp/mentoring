# == Schema Information
#
# Table name: forem_topics
#
#  id           :integer          not null, primary key
#  forum_id     :integer
#  user_id      :integer
#  subject      :string
#  created_at   :datetime
#  updated_at   :datetime
#  locked       :boolean          default(FALSE), not null
#  pinned       :boolean          default(FALSE)
#  hidden       :boolean          default(FALSE)
#  last_post_at :datetime
#  state        :string           default("pending_review")
#  views_count  :integer          default(0)
#  slug         :string
#

require Forem::Engine.root.join('app', 'models', 'forem', 'topic')

class Forem::Topic
  include PublicActivity::Model
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  tracked only: [:create], owner: :user
end
