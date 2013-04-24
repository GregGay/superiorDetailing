class SessionsController < ApplicationController

#Creates new session when you sign up
  def new
  end

#Creates a session when you sign in
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email and/or password'
      render 'new'
    end
  end

#Destroys session when you sign out
  def destroy
    sign_out
    redirect_to root_url
  end
end