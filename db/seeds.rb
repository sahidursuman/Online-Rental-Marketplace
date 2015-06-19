User.create!(first_name:  "Example",
			 last_name: "User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

10.times do |n|
  firstname  = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  firstname,
  			   last_name: lastname,
               email: email,
               password:              password,
               password_confirmation: password)
end