class User < ActiveRecord::Base
  has_many :children, foreign_key: :mentor_id
  has_many :meetings, foreign_key: :mentor_id
  has_many :subordinates, class_name: 'User', foreign_key: :curator_id
  belongs_to :orphanage
  belongs_to :curator, class_name: 'User'

  rolify

  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  def name
    first_name
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end

  def forem_name
    email
  end

  def subordinate_ids
    if user.has_role? :curator
      self.subordinates.map(&:id)
    else
      nil
    end
  end
end
