class ReportsMailer < ApplicationMailer
  def new_report report
    @report = report

    mail to: report.meeting.mentor.curator.email,
         subject: "Наставничество: новый отчёт от #{report.meeting.mentor.full_name}"
  end
end
