class BooksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @top_priority = @books.immediately_read.order(created_at: :desc)
    @high_priority = @books.must_read.order(created_at: :desc)
    @medium_priority = @books.interesting.order(created_at: :desc)
  end

  def show
    @commentable = @book
    @comments = @book.comments
  end

  def new
  end

  def create
    if @book.save
      redirect_to books_path, notice: 'Новая книга добавленна.'
    else
      render :new, notice: 'Не удалось добавить книгу.', error: @book.errors[:name].first
    end
  end

  def destroy
    if @book.destroy
      flash[:notice] = 'Книга была успешно удалёна.'
    else
      flash[:notice] = 'Книгу не удалось удалить.'
      flash[:error] = @book.errors[:name].first
    end

    redirect_to books_url
  end

  private
    def book_params
      params.require(:book).permit(:name, :priority, :file, :owner_id)
    end
end
