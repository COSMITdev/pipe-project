# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

if Rails.env.development?
  10.times do |i|
    User.create!(email: "user_#{i+1}@example.com",
                 name: "User Name #{i+1}",
                 password: "123123123")
  end
end
