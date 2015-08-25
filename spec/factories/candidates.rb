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

    health_status "ok"
    serious_diseases "no"

    work_start_date 10.years.ago
    work_end_date nil
    organization_name "Al'Kaida"
    work_contacts "911"
    work_position "Leader"
    work_functions "Exploding"
    work_schedule "9:00-18:00"

    hobby "Exploding"

    martial_status "married"

    house_type "House"
    number_of_rooms "22"
    peoples_for_room "1"
    peoples "22"
    pets "yes, one bear"

    program_role "Mentor"
    program_reason "Because i can"
    person_character "Exploding character"
    person_information "I love to explode"
    help_reason "no reason"

    child_age "10"
    child_gender "M"
    child_character "Any"

    visit_frequency "every day"
    invalid_child true

    alcohol "yes, every day"
    tobacco "yes"
    psychoactive "yes, LSD-25, DMT, DOB, 2C-B etc"
    drugs "yes, heroin, cocain, methamphetamin etc"
    child_crime "no"
    disabled_parental_rights "no"

    reports true
    photo_rights true
    info_about_program "internet"

    candidate_educations {[FactoryGirl.build(:candidate_education)]}
    candidate_family_members {[FactoryGirl.build(:candidate_family_member)]}
    candidate_children_experiences {[FactoryGirl.build(:candidate_children_experience)]}

  end

end
