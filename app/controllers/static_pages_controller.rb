class StaticPagesController < ApplicationController
  def home
    @appointment = current_user.appointments.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
