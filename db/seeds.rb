# Clear any existing records (optional but helps in test environments)
User.destroy_all
Patient.destroy_all

# Create Receptionists and Doctors with predefined credentials

# Receptionist User
receptionist = User.create!(
  email: 'receptionist@example.com',
  password: 'password123',  # Set the password for the receptionist
  password_confirmation: 'password123',
  role: 'receptionist'
)

# Doctor User
doctor = User.create!(
  email: 'doctor@example.com',
  password: 'password123',  # Set the password for the doctor
  password_confirmation: 'password123',
  role: 'doctor'
)

# Optionally, you can create more users with different credentials
doctor2 = User.create!(
  email: 'doctor2@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'doctor'
)

# Create Patients associated with Receptionist
5.times do |i|
  Patient.create!(
    first_name: "John#{i}",
    last_name: "Doe#{i}",
    dob: Date.new(1990, 1, 1),
    phone: "123-456-7890#{i}",
    address: "123 Main St #{i}",
    user: receptionist  # Associate the receptionist user with each patient
  )
end

# You can also create some dummy patients associated with doctors for testing
5.times do |i|
  Patient.create!(
    first_name: "Jane#{i}",
    last_name: "Smith#{i}",
    dob: Date.new(1992, 5, 10),
    phone: "098-765-4321#{i}",
    address: "456 Oak Rd #{i}",
    user: doctor  # Associate doctor with patients
  )
end

# Output to confirm data has been seeded
puts "Seed data created successfully!"
