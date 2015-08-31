# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  album_id           :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :photo do
    description "MyText"
    image Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/image.png", 'image/png')
    album nil
    user User.first
  end

end
