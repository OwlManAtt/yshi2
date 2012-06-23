class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth == nil 
      redirect_to root_url, :error => "Unable to create session. Please contact administrator."
    else
      @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end 

  def failure
    # TODO log something
  end
end
