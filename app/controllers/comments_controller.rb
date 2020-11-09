class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to book_path(@comment.book)
    else
      @book = @comment.book
      @comments = @book.comments
      render "comments/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
