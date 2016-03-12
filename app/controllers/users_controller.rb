class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create, :index]
  
  def index
    if signed_in? then
      redirect_to reports_path
    else
      @user = User.find_by_user_name("admin")
      if (@user == nil) then
        @user = User.new
        @user.user_name = "admin"
        @create_admin_account = true
      else
        redirect_to signin_path
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @titre = "Édition profil"
  end  
  
  def create
    @user = User.new(user_params)
    if (@user.save) then
      flash[:info] = "user correctly created"
      sign_in @user
      redirect_to root_url
    else
      flash[:error] = "unable to create user, try again"
      render "new"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

private 
  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end  
end
