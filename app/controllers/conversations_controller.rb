class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :reply, :trash, :untrash]

  def new
    if current_user.has_role? :admin
      @users = User.where.not(id: current_user.id)
    else
      @users = User.for_messaging(current_user)
    end
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    if recipients.present?
      message = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject])
      MailboxMailer.new_message(recipients, current_user).deliver_now
      redirect_to conversation_path(message.conversation), notice: 'Ваше сообщение было успешно отпавленно!'
    else
      redirect_to new_conversation_path, alert: 'Вы не можете создать диалог без адресатов!'
    end
  end

  def show
    @receipts = @conversation.receipts_for(current_user)
    @conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(@conversation, message_params[:body])
    flash[:notice] = 'Ваше ответное сообщение было успешно отправленно'
    MailboxMailer.new_message(@conversation.recipients.delete(current_user), current_user).deliver_now
    redirect_to conversation_path(@conversation)
  end

  def trash
    @conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    @conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private
    def set_conversation
      @conversation = mailbox.conversations.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:subject, :body)
    end

    def conversation_params
      params.require(:conversation).permit(:subject, :body, recipients: [])
    end
end
