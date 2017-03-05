class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :show, :update]
  before_action :check_userid_session_vs_current, only: [:show, :edit, :update]

  def edit
  end
  
  def show
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました！"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :profile, :area,  
                                 :password_confirmation)
  end
  
  def check_userid_session_vs_current
    if @user.id != session[:user_id]
      flash[:danger] = "ログイン中のアカウントではありません．"
      redirect_to login_url
    end
  end
  
end
