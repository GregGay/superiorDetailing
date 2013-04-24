class AppointmentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy]

#Creates an appointment
  def create
    @appointment = current_user.appointments.build(params[:appointment])
    if @appointment.save
      flash[:success] = "Appointment created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

#Destroys an appointment
  def destroy
    current_user.appointments.find_by_id(params[:id]).destroy
    flash[:success] = "Appointment destroyed!"
    redirect_to root_url
  end

  private
    #Private method to check if the user is the correct user
    def correct_user
      @appointment = current_user.appointments.find_by_id(params[:id])
      redirect_to root_url if @appointment.nil?
    end
end
