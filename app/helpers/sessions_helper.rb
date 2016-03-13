module SessionsHelper

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end    
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.password_salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def deny_access
    store_location  
    flash[:notice] =  "Thanks to registering before to display this page."
    redirect_to root_path
  end
  
  def authenticate
      deny_access unless signed_in?
  end  

private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token) #*->transforme le tableau remember_token en deux variables
  end
  
  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end  
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
end

