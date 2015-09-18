# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string
#  last_name              :string
#  middle_name            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  curator_id             :integer
#  forem_admin            :boolean          default(FALSE)
#  forem_state            :string           default("pending_review")
#  forem_auto_subscribe   :boolean          default(FALSE)
#  orphanage_id           :integer
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  has_many :children, foreign_key: :mentor_id
  has_many :meetings, foreign_key: :mentor_id
  has_many :subordinates, class_name: 'User', foreign_key: :curator_id
  has_many :books, foreign_key: :owner_id
  has_many :comments
  has_many :albums
  has_many :photos
  belongs_to :orphanage
  belongs_to :curator, class_name: 'User'

  acts_as_messageable
  rolify
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  has_attached_file :avatar
  validates_attachment_size :avatar, less_than: 1.megabytes
  validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png image/gif)

  validates :email,      presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name,  presence: true

  scope :for_messaging, -> (user) do
    joins(:roles).where('roles.name' => [:employee, :mentor, :curator])
                 .where('users.orphanage_id' => user.orphanage_id)
                 .where('users.id != ?', user.id)
  end


  def name
    full_name
  end

  def mail_email object
    email
  end

  def mail_name
    "#{full_name}  (#{email})"
  end

  def name_with_roles
    "#{full_name} (#{translated_roles.join(', ')})"
  end

  def translated_roles
    roles.map{|r| I18n.t("activerecord.attributes.role.name/#{r.name}", default: r.name)}
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end

  def forem_name
    mail_name
  end

end
