require "faker"

Availability.delete_all
Booking.delete_all
Boat.delete_all
User.delete_all

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
  user = User.all.sample
  boat = Boat.new(
    name: Faker::Hipster.word,
    location: Faker::Address.city,
    capacity: (0..5).to_a.sample,
    user_id: user.id,
    price: (50..350).to_a.sample
  )
  boat.save
end

# Still needs status and review rating and content
25.times do
  user = User.all.sample
  boat = Boat.all.sample
  booking = Booking.new(
  start_date: Faker::Date.backward(10),
  end_date: Faker::Date.forward(20),
  user_id: user.id,
  boat_id: boat.id
  )
  booking.save
end

75.times do
  boat = Boat.all.sample
  availability = Availability.new(
  start_date: Faker::Date.backward(20),
  end_date: Faker::Date.forward(40),
  boat_id: boat.id
  )
  availability.save
end
