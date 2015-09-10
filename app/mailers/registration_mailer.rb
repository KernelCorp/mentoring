class RegistrationMailer < ApplicationMailer

  def welcome user, password
    @user = user
    @password = password
    mail to: user.email, subject: 'Ваша заявка одобрена'
  end
end
