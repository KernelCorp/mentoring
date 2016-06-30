class CandidatesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :update, :approve]
  load_and_authorize_resource only: [:index, :show, :update, :approve]

  def index
  end

  def show
  end

  def new
    @candidate = Candidate.new
    @candidate.candidate_educations.new
    @candidate.candidate_family_members.new
    @candidate.candidate_children_experiences.new
    render layout: 'main'
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      CandidatesMailer.bid_received(@candidate).deliver_now
      CandidatesMailer.bid_sent(@candidate).deliver_now
      render template: 'candidates/success', layout: 'main'
    else
      render :new, layout: 'main'
    end
  end

  def update
    if @candidate.update(state_comment_params)
      redirect_to @candidate, notice: 'Комментарий успешно обновлён.'
    else
      render :show, notice: 'Комментарий не удалось изменить.'
    end
  end

  def approve
    if @candidate.approve and @candidate.save
      flash[:notice] = 'Вы одобрили кандидата.'
    else
      flash[:notice] = 'Кандидата не удалось одобрить.'
      flash[:error] = @candidate.errors.full_messages.first
    end

    redirect_to @candidate, flash: {error: flash[:error]}
  end

  private
    def state_comment_params
      params.require(:candidate).permit(:state_comment)
    end

    def candidate_params
      params.require(:candidate)
            .permit(:last_name, :first_name, :middle_name, :registration_address, :home_address, :phone_number, :email,
                    :birth_date, :russian_citizenship, :confession, :health_status, :serious_diseases, :work_start_date,
                    :work_end_date, :organization_name, :work_contacts, :work_position, :work_functions, :work_schedule,
                    :hobby, :martial_status, :house_type, :number_of_rooms, :peoples_for_room, :peoples, :pets,
                    :program_role, :program_reason, :person_character, :person_information, :help_reason, :child_age,
                    :child_gender, :child_character, :visit_frequency, :invalid_child, :alcohol, :tobacco,
                    :psychoactive, :drugs, :child_crime, :disabled_parental_rights, :reports, :photo_rights,
                    :info_about_program,
                    candidate_educations_attributes:
                        [:education, :start_date, :end_date, :institution, :specialty],
                    candidate_family_members_attributes:
                        [:name, :gender, :age, :relation],
                    candidate_children_experiences_attributes:
                        [:organization_name, :organization_contacts, :position, :functions, :children_age])
    end
end
