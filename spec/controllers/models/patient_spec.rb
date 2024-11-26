# spec/models/patient_spec.rb
require 'rails_helper'

RSpec.describe Patient, type: :model do
  let(:user) { create(:user) }

  # Test the associations
  describe 'associations' do
    it 'belongs to a user' do
      patient = Patient.new(user: user)
      expect(patient.user).to eq(user)
    end
  end

  # Test the validations (there should be no validation errors)
  describe 'validations' do
    it 'is valid with valid attributes' do
      patient = Patient.new(
        first_name: "John", # Can be nil because no validation is required for first_name
        last_name: "Doe",  # Can be nil because no validation is required for last_name
        dob: "1990-01-01",
        phone: "1234567890",
        address: "123 Main St",
        user: user
      )
      expect(patient).to be_valid
    end

    it 'is valid without a first_name' do
      patient = Patient.new(first_name: nil, last_name: "Doe", dob: "1990-01-01", phone: "1234567890", address: "123 Main St", user: user)
      expect(patient).to be_valid
    end

    it 'is valid without a last_name' do
      patient = Patient.new(first_name: "John", last_name: nil, dob: "1990-01-01", phone: "1234567890", address: "123 Main St", user: user)
      expect(patient).to be_valid
    end

    it 'is valid without a dob' do
      patient = Patient.new(first_name: "John", last_name: "Doe", dob: nil, phone: "1234567890", address: "123 Main St", user: user)
      expect(patient).to be_valid
    end

    it 'is valid without a phone' do
      patient = Patient.new(first_name: "John", last_name: "Doe", dob: "1990-01-01", phone: nil, address: "123 Main St", user: user)
      expect(patient).to be_valid
    end

    it 'is valid without an address' do
      patient = Patient.new(first_name: "John", last_name: "Doe", dob: "1990-01-01", phone: "1234567890", address: nil, user: user)
      expect(patient).to be_valid
    end

    it 'is invalid without a user' do
      patient = Patient.new(first_name: "John", last_name: "Doe", dob: "1990-01-01", phone: "1234567890", address: "123 Main St")
      expect(patient).not_to be_valid
      expect(patient.errors[:user]).to include("must exist")
    end
  end
end
