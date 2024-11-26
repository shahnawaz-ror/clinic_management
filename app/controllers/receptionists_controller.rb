class ReceptionistsController < ApplicationController
  before_action :authenticate_user!  # Make sure user is logged in
  before_action :authorize_receptionist

  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.user = current_user  # Associate patient with the current user (receptionist)

    if @patient.save
      redirect_to receptionists_path, notice: 'Patient registered successfully.'
    else
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      redirect_to receptionists_path, notice: 'Patient updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to receptionists_path, notice: 'Patient deleted successfully.'
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :dob, :phone, :address)
  end

  def authorize_receptionist
    redirect_to new_user_session_path, alert: 'Access denied.' unless current_user.role == 'receptionist'
  end
end
