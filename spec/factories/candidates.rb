FactoryGirl.define do
  factory :candidate do
    last_name "Laden"
    first_name "Osama"
    middle_name "Bin"
    registration_address "Pakistan, Al'Kaida Street"
    home_address "Same as registration adress"
    phone_number "+71112223344"
    email "osama@alkaida.com"
    birth_date 50.years.ago
    nationality "Pakistan"
    confession "Islam"
  end

end
