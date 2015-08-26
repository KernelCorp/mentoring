class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @commentable = @comment.commentable

    if @comment.save
      redirect_to @commentable, notice: 'Новый комментарий добавлен.'
    else
      redirect_to @commentable, notice: 'Не удалось добавить комментарий.', error: @comment.errors[:name].first
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id, :commentable_type, :commentable_id)
    end
end
