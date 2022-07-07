# Create a main sample user.
User.create!(name: "Zukisani Zamela",
              email: "codewithzuks@gmail.com",
              password: "abc123",
              password_confirmation: "abc123")

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email_prefix = "example" + (n == 0 ? "" : "-#{n}")
  email = "#{email_prefix}@railstutorial.org"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end