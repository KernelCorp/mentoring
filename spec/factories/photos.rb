FactoryGirl.define do
  factory :photo do
    description "MyText"
    image Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/image.png", 'image/png')
    album nil
    user User.first
  end

end
