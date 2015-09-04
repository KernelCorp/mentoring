class CandidatesMailer < ApplicationMailer

  def bid_received candidate
    @candidate = candidate
    admins = User.with_role(:admin).all

    if admins.present?
      mail to: admins.map(&:email),
           subject: "Заполнена анкета кандидата: #{@candidate.full_name}"
    end
  end
end
