class CandidatesMailer < ApplicationMailer

  def bid_received candidate
    @candidate = candidate
    admins = User.with_role(:admin).all

    if admins.present?
      mail to: admins.map(&:email),
           subject: "Заполнена анкета кандидата: #{@candidate.full_name}"
    end
  end

  def bid_sent candidate
    @candidate = candidate

    mail to: candidate.email,
         subject: 'Ваша анкета рассматривается'
  end
end
