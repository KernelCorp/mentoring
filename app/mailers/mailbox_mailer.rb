class MailboxMailer < ApplicationMailer
  def new_message recipients, from
    if recipients.present?
      mail to: [recipients].flatten.map(&:email),
           subject: "Наставничество: новое сообщение от #{from.full_name}"
    end
  end
end
