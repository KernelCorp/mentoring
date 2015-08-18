class Child < ActiveRecord::Base
  belongs_to :orphanage
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User'
  has_many :meetings

  def name
    first_name
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
