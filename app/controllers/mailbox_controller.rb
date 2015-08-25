class MailboxController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox = mailbox.inbox
  end

  def sent
    @sent = mailbox.sentbox
  end

  def trash
    @thrash = mailbox.trash
  end
end
