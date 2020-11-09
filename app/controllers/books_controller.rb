class BooksController < ApplicationController
  def index
  end

  def new
    @book = Book.new
  end
  
  def create
    
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :impression, :author, :image).merge(user_id: current_user.id)
  end
end
