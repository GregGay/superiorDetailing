class StaticPagesController < ApplicationController
  def home
    #@appointment = current_user.appointments.build if signed_in?
  end

  def help
    @appointment = current_user.appointments.build if signed_in?
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def about
  end

  def contact
  end
end
