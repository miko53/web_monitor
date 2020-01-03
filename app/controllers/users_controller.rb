class UsersController < ApplicationController
  before_action :authenticate, :except => [:new, :create, :home]
  before_action :correct_user, :only => [:edit, :update]
  before_action :admin_user,   :only => [:destroy, :update_api_key, :display_syslog, :display_kernel_log]
  
  def index
    @users = User.all
  end
  
  def home
    if signed_in? then
      if current_user.dash_board == nil then
        current_user.dash_board = DashBoard.new
        current_user.save
      end
      
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
    @user.dash_board = DashBoard.new
  end
  
  #user already set by before_action
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
  
  def display_syslog
    lines = params[:lines]
    @logs = `tail -n #{lines} /var/log/syslog`
  end
  
  def display_kernel_log
    lines = params[:lines]
    @logs = `cat /var/log/messages | grep kernel`    
  end
  
  #user already set by before_action
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
