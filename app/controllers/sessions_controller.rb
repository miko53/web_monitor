class SessionsController < ApplicationController
  def new
  end
  
def create
  user = User.authenticate(session_params[:user_name], session_params[:password])
  if user then
    session[:user_id] = user.id
    sign_in user
    flash[:notice] = "Logged in!"
    redirect_to root_url 
  else
    flash.now.alert = "Invalid username or password"
    render "new"
  end
end

def destroy
  sign_out
  redirect_to root_path
end  

private 
  def session_params
    params.require(:session).permit(:user_name, :password)
  end  
end
