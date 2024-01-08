# Create a main sample user.
User.create!(name:  "Example User",
             email: "example@worklifechaos.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
User.create!(name:  "C Rance",
             email: "clsterance@gmail.com",
             password:              "Password1",
             password_confirmation: "Password1",
             admin: true)             
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@worklifechaos.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end