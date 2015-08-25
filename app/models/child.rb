class Child < ActiveRecord::Base
  belongs_to :orphanage
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User'
  has_many :meetings

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def name
    first_name
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
