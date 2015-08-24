class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      # general information
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :registration_address
      t.string :home_address
      t.string :phone_number
      t.string :email
      t.date :birth_date
      t.string :nationality
      t.string :confession

      # health status
      t.string :health_status
      t.string :serious_diseases

      # education

      # job
      t.date :work_start_date
      t.date :work_end_date
      t.string :organization_name
      t.string :work_contacts
      t.string :work_position
      t.text :work_functions
      t.string :work_schedule

      # hobbies
      t.text :hobby

      # family
      t.string :martial_status

      # living conditions
      t.string :house_type
      t.string :number_of_rooms
      t.string :peoples_for_room
      t.text :peoples
      t.string :pets

      # children experience

      # important questions
      t.string :program_role
      t.text :program_reason
      t.text :person_character # черты характера
      t.text :person_information # опишите себя
      t.text :help_reason

      t.string :child_age
      t.string :child_gender
      t.text :child_character

      t.string :visit_frequency
      t.boolean :invalid_child

      t.string :alcohol
      t.string :tobacco
      t.string :psychoactive
      t.string :drugs
      t.string :child_crime
      t.string :disabled_parental_rights

      t.boolean :reports
      t.boolean :photo_rights
      t.string :info_about_program

      t.string :state
      t.timestamps null: false
    end
  end
end
