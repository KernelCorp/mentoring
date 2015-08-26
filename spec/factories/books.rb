FactoryGirl.define do
  factory :book do
    name '1984'
    priority 1
    owner_id 1
    file File.open("#{Rails.root}/public/robots.txt")
  end

end
