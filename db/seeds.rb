puts "Destroying"
Reservation.destroy_all
Cookoon.destroy_all
UserSearch.destroy_all
User.destroy_all

users_attributes = [
  {email: 'charles@cookoon.fr', password: 'plopplop', first_name: 'Charles', last_name: 'Pernet', description: 'Un user heureux', phone_number: '0660283574', photo_url: "https://ca.slack-edge.com/T0A4A3AQZ-U5C18PEJZ-13810bfae838-512" },
  {email: 'quentin@cookoon.fr', password: 'plopplop', first_name: 'Quentin', last_name: 'Pernez', description: 'Un bon user', phone_number: '0636686565', photo_url: "https://ca.slack-edge.com/T0A4A3AQZ-U0A5L9L8K-7eda5a7e311c-512" }
]
puts "Seeding Users"
users_attributes.each { |attributes| User.create! attributes }
puts "Users done"

cookoons_attributes = [
  {user: User.first, name: "Appartement Cosy", surface: 90, price_cents: 7000, price_currency: "EUR", address: "51 rue Ligier, 33000 Bordeaux", capacity: "12", category: 'Appartement'},
  {user: User.last, name: "Veranda", surface: 120, price_cents: 10000, price_currency: "EUR", address: "1 rue Eugène Eichenberger, 92800 Puteaux", capacity: "10", category: 'Toit'}
]
puts "Seeding Cookoons"
cookoons_attributes.each { |attributes| Cookoon.create! attributes }
puts "Cookoons done"

puts "Adding Photos to Cookoons"
Cookoon.first.photo_urls = ["http://www.domaine-de-capelongue.com/wp-content/uploads/2014/02/Appartement-Mezzanine.jpg", "http://img-6.ccmbg.com/bWcTxZ9O4nyj0ZFFYwXXDIioRVI=/acfdad0f975c46229b2aaccdfb708e10/ccm-ugc/coqXPZVqXfrz2I68HoA0oIf0wAiAjK4jHG4uzNQ9P0Ao0gfVhbTISTnz76zuqxC5-mezzanine-fenetres-atelier.png"]
Cookoon.last.photo_urls = ["http://www.ehometu.com/uploads/allimg/130430/16031915W-1.jpg", "http://images.lodgis.com/photos/lpa/ap/15441/orange/carousel/g/apartment-paris-living-room-G11.jpg?v=1464875569"]
puts "Pictures done"
