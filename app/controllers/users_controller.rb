class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
    
  end

  def create
    
    @book = Book.new(book_params)
    if @book.save
      redirect_to "/books/#{@book.id}", notice: "Book was successfully created."
    else
      @books = Book.all
      render 'index'
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
