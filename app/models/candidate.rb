class Candidate < ActiveRecord::Base
  include AASM

  has_many :candidate_educations
  has_many :candidate_family_members
  has_many :candidate_children_experiences
  accepts_nested_attributes_for :candidate_educations
  accepts_nested_attributes_for :candidate_family_members
  accepts_nested_attributes_for :candidate_children_experiences

  validates_presence_of :first_name, :last_name, :middle_name, :registration_address, :home_address, :phone_number,
                        :email, :birth_date, :nationality, :confession, :health_status, :serious_diseases, :work_start_date,
                        :organization_name, :work_contacts, :work_position, :work_functions, :work_schedule, :hobby,
                        :martial_status, :house_type, :number_of_rooms, :peoples_for_room, :peoples, :pets, :program_role,
                        :program_reason, :person_character, :person_information, :help_reason, :child_age, :child_gender,
                        :child_character, :visit_frequency, :invalid_child, :alcohol, :tobacco, :psychoactive, :drugs,
                        :child_crime, :disabled_parental_rights, :reports, :photo_rights, :info_about_program


  validates_uniqueness_of :email
  validates_format_of     :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/

  GENDERS = ['Мужской', 'Женский']
  EDUCATION_TYPES = ['Общеобразовательная школа', 'Университет, Институт, техникум', 'Дополнительные курсы, тренинги, семинары']
  MARTIAL_STATUSES = ['Женат (замужем)', 'Гражданский брак', 'Разведён (разведена)', 'Вдовец (вдова)', 'Не женат (не замужем)']
  HOUSE_TYPES = ['Квартира', 'Частный дом', 'Арендованное жильё']
  PROGRAM_ROLES = ['Наставника', 'Волонтёра', 'Партнёра (оказывать единоразовую/постоянную финансовую поддержку)']

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :approved

    event :approve do
      after do
        generated_password = Devise.friendly_token.first(8)
        user = User.create(email: email, first_name: first_name, last_name: last_name, middle_name: middle_name, password: generated_password)
        RegistrationMailer.welcome(user, generated_password).deliver_later
      end
      transitions from: :new, to: :approved
    end

  end

end
