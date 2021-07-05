class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def show
    @showbook = Book.find(params[:id])
    @user = @showbook.user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to "/books/#{@book.id}", notice: "You have updated book successfully ."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

  private

  def book_params
   params.require(:book).permit(:title,:body)
  end
  
  
  def correct_user
    unless Book.find(params[:id]).user_id == current_user.id
        redirect_to "/books"
    end
  end
end
