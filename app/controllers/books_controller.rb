class BooksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @books = @books.order :priority
  end

  def show
  end

  def new
  end

  def create
    if @book.save
      redirect_to @book, notice: 'Новая книга добавленна.'
    else
      render :new, notice: 'Не удалось добавить книгу.', error: @book.errors[:name].first
    end
  end

  private
    def book_params
      params.require(:book).permit(:name, :priority, :file)
    end
end
