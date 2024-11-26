# spec/controllers/doctors_controller_spec.rb
require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  # Setup test data
  let!(:doctor) { create(:user, role: 'doctor') }  # Assuming you have a factory for users with role 'doctor'
  let!(:patient) { create(:patient) }  # Assuming you have a factory for patients
  let!(:non_doctor) { create(:user, role: 'receptionist') }  # Another user with a different role
  
  # Tests for index action
  describe "GET #index" do
    context "when logged in as a doctor" do
      before do
        sign_in doctor  # Now sign_in should work
        get :index
      end

      it "assigns @patients" do
        expect(assigns(:patients)).to eq([patient])  # Adjust to your actual setup, multiple patients if needed
      end

      it "responds successfully" do
        expect(response).to be_successful
      end
    end

    context "when logged in as a non-doctor" do
      before do
        sign_in non_doctor  # Now sign_in should work
        get :index
      end

      it "redirects to the login page (new_user_session_path)" do
        expect(response).to redirect_to(new_user_session_path)  # Adjust to your actual redirect path
      end

      it "sets an alert flash message" do
        expect(flash[:alert]).to eq('Access denied.')
      end
    end
  end

  # Tests for graph action
  describe "GET #graph" do
    before do
      sign_in doctor  # Now sign_in should work
      get :graph
    end

    it "assigns @patient_counts" do
      # Ensure the date is in 'YYYY-MM-DD' format
      expect(assigns(:patient_counts)).to eq({ patient.created_at.to_date.strftime("%Y-%m-%d") => 1 })
    end


    it "responds successfully" do
      expect(response).to be_successful
    end
  end

  # Tests for authorize_doctor callback
  describe "Access control" do
    it "redirects non-doctor users" do
      sign_in non_doctor  # Now sign_in should work
      get :index
      expect(response).to redirect_to(new_user_session_path)  # Adjust to your actual redirect path
    end
  end
end
