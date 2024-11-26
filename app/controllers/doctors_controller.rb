# app/controllers/doctors_controller.rb
class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_doctor, only: [:index, :graph]  # Protect index and graph actions

  def index
    @patients = Patient.all  # Example, adjust based on your requirements
  end

  def graph
    @patient_counts = Patient.group_by_day(:created_at).count
    @patient_counts = @patient_counts.transform_keys { |date| date.strftime("%Y-%m-%d") }  # Return in YYYY-MM-DD format
  end

  private

  def authorize_doctor
    unless current_user.role == 'doctor'
      redirect_to new_user_session_path, alert: 'Access denied.'
    end
  end
end
