Role.create!(name: "normal")
Role.create!(name: "admin")

User.create!(name: "admin123", email: "admin123@gmail.com", score: 10,
  phone_number: "0963740311", role_id: 2, password: "password")
User.create!(name: "vuvanquy", email: "vuvanquy1998realkio@gmail.com", score: 10,
  phone_number: "0963740311", password: "password")

20.times do |n|
  User.create!(name: "name#{n}", password: "password", score: 10,
    email: "user#{n+1}@gmail.com", phone_number: "0963740311")
end
