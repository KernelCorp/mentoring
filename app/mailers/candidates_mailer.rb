class CandidatesMailer < ApplicationMailer

  def bid_received candidate
    @candidate = candidate

    mail to: User.with_role(:admin).map(&:email),
         subject: "Заполнена анкета кандидата: #{@candidate.full_name}"
  end
end
