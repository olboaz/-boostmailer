# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Customer.destroy_all

User1 = User.new(email: "ppastg92@free.fr", password: 123456)
User1.save

Customer1 = Customer.new(restaurant_name: "Le bartop", email: "spalkes04@gmail.com", first_name: "Patrcie", last_name: "La menace qui tue ", user: User1)
Customer1.save
