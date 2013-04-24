class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

#Shows the user inforamtion and appointments
  def show
    @user = User.find(params[:id])
    @appointments = @user.appointments
  end

  def new
    @user = User.new
  end

#Creates an account
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Superior Detailing " + @user.firstname + " " + @user.lastname + "!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

#Updates user information
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

#Lists all the users
  def index
    @users = User.all
  end

#Destroys an account, only administrators can destroy accounts
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account has been destroyed!"
    redirect_to users_url
  end

  private
    #Private method to check if the user is signed in
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    #Private method to check if the user is the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    #Administrator can only destroy user accounts
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end