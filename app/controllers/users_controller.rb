class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book),notice: "You have created book successfully."
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
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id),notice: "You have updated user successfully."
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
   params.require(:book).permit(:title,:body)
  end

end
