class CandidatesController < ApplicationController
  def new
    @candidate = Candidate.new
    3.times { @candidate.candidate_educations.build }
    6.times { @candidate.candidate_family_members.build }
    2.times { @candidate.candidate_children_experiences.build }
    render layout: 'candidate'
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      render template: 'candidates/success', layout: 'candidate'
    else
      render :new, layout: 'candidate'
    end
  end

  private
    def candidate_params
      params.require(:candidate).permit(:last_name, :first_name, :middle_name, :registration_address, :home_address,
                                        :phone_number, :email, :birth_date, :nationality, :confession, :health_status,
                                        :serious_diseases, :work_start_date, :work_end_date, :organization_name, :work_contacts,
                                        :work_position, :work_functions, :work_schedule, :hobby, :martial_status, :house_type,
                                        :number_of_rooms, :peoples_for_room, :peoples, :pets, :program_role, :program_reason,
                                        :person_character, :person_information, :help_reason, :child_age, :child_gender,
                                        :child_character, :visit_frequency, :invalid_child, :alcohol, :tobacco, :psychoactive,
                                        :drugs, :child_crime, :disabled_parental_rights, :reports, :photo_rights, :info_about_program,
                                        candidate_educations_attributes: [:education, :start_date, :end_date, :specialty],
                                        candidate_family_members_attributes: [:name, :gender, :age, :relation],
                                        candidate_children_experiences_attributes:
                                        [:organization_name, :organization_contacts, :position, :functions, :children_age])
    end
end
