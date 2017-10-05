class UsersController < ApplicationController
    before_action :require_user_logged_in, only: [:index, :show]
 
  def index
    @user = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User
    
    if @user.save
      flash[:success] = "ユーザー登録を完了しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザー登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
