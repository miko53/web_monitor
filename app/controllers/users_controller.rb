class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create, :home]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy, :update_api_key]
  
  def index
    @users = User.all
  end
  
  def home
    if signed_in? then
      redirect_to dashboard_path(current_user.dash_board)
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
  
  #user already set by before_filter
  def edit
  end  
  
  def update_api_key
    @user = User.find_by_user_name("admin")
    @user.generate_api_key
    if (@user.save) then
      flash[:info] = "api_key regenerated"
    else
      flash[:error] = "api_key generation failed"
    end
    redirect_to user_url(@user)
  end
  
  #user already set by before_filter
  def update
    if (@user.update(user_params)) then
      flash[:info] = "profile correctly updated"
      redirect_to user_url(@user)
    else
      flash[:error] = "profile update failed"
      render :edit
    end
    
  end
  
  def create
    @user = User.new(user_params)
    @user.dash_board = DashBoard.new
    if (@user.save) then
      flash[:info] = "user correctly created"
      if (@user.user_name == 'admin') then
        sign_in @user
      end
      redirect_to user_path(current_user)
    else
      flash[:error] = "unable to create user, try again"
      render "new"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:info] = "user correctly removed"
    redirect_to users_path
  end
  
private 
  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end  
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def correct_user
    @user = User.find(params[:id])
    if ((!current_user.admin?) && (!current_user?(@user))) then
      redirect_to(root_path)
    end
  end
  
end
