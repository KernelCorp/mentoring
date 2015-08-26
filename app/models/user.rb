class User < ActiveRecord::Base
  has_many :children, foreign_key: :mentor_id
  has_many :meetings, foreign_key: :mentor_id
  has_many :subordinates, class_name: 'User', foreign_key: :curator_id
  has_many :books, foreign_key: :owner_id
  has_many :comments
  belongs_to :orphanage
  belongs_to :curator, class_name: 'User'

  acts_as_messageable
  rolify
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  validates :email,      presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true


  def name
    full_name
  end

  def mail_email object
    email
  end

  def mail_name
    "#{full_name} (#{email})"
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end

  def forem_name
    email
  end

end
