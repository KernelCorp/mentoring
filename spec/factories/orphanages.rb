# == Schema Information
#
# Table name: orphanages
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :orphanage do
    name "MyString"
    address "MyString"
  end

end
