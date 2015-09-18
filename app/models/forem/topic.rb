require Forem::Engine.root.join('app', 'models', 'forem', 'topic')

class Forem::Topic
  include PublicActivity::Model
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  tracked only: [:create], owner: :user
end
