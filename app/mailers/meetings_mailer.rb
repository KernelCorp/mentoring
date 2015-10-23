class MeetingsMailer < ApplicationMailer
  def meeting_notification meeting
    @meeting = meeting

    if meeting.new?
      mail to: meeting.mentor.email,
           subject: 'Напоминание о встрече'
    end
  end
end
