require 'faker'
User.delete_all
Boat.delete_all
Availability.delete_all

50.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456'
  )
  user.save
end

# Still needs picture
10.times do
  boat = Boat.new(
    name: Faker::Company.catch_phrase,
    location: Faker::Address.city,
    capacity: (1..5).to_a.sample,
    user_id: (1..50).to_a.sample
  )
  boat.save
end

# Still needs status and review rating and content
25.times do
  availability = Availability.new(
  start_date: Faker::Date.backward(10),
  end_date: Faker::Date.forward(20),
  boat_id: (1..10).to_a.sample
  )
  availability.save
end
