puts "Destroying"
Cookoon.destroy_all
User.destroy_all

users_attributes = [
  {email: 'charlespernet@gmail.com', password: 'plopplop', first_name: 'Charles', last_name: 'Pernet', description: 'Un user heureux', phone_number: '0660283574'},
  {email: 'toto@gmail.com', password: 'plopplop', first_name: 'Toto', last_name: 'Lebon', description: 'Un bon user', phone_number: '0660283575'}
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
