puts "Destroying"
Reservation.destroy_all
Cookoon.destroy_all
User.destroy_all

users_attributes = [
  {email: 'charles@cookoon.fr', password: 'plopplop', first_name: 'Charles', last_name: 'Pernet', description: 'Un user heureux', phone_number: '0660283574', photo_url: "https://ca.slack-edge.com/T0A4A3AQZ-U5C18PEJZ-13810bfae838-512" },
  {email: 'quentin@cookoon.fr', password: 'plopplop', first_name: 'Quentin', last_name: 'Pernez', description: 'Un bon user', phone_number: '0636686565', photo_url: "https://ca.slack-edge.com/T0A4A3AQZ-U0A5L9L8K-7eda5a7e311c-512" }
]
puts "Seeding Users"
users_attributes.each { |attributes| User.create! attributes }
puts "Users done"

cookoons_attributes = [
  {user: User.first, name: "Penthouse", surface: 200, price_cents: 20000, price_currency: "EUR", address: "16 Villa Gaudelet, 75011 Paris", capacity: "150"},
  {user: User.first, name: "Veranda", surface: 120, price_cents: 10000, price_currency: "EUR", address: "1 rue Eugène Eichenberger, 92800 Puteaux", capacity: "10"},
  {user: User.last, name: "Bureaux", surface: 300, price_cents: 15000, price_currency: "EUR", address: "12 rue Lincoln - 75008 Paris", capacity: "80"}
]
puts "Seeding Cookoons"
cookoons_attributes.each { |attributes| Cookoon.create! attributes }
puts "Cookoons done"

Reservation.create!(duration: 2, date: DateTime.now, user: User.last, cookoon: Cookoon.first, price_cents: 45000)
