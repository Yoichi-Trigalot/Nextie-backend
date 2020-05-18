# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'yo@gmail.com', password_digest: 'secret', admin: true)

user1 = User.create(email: 'john@gmail.com', password_digest: 'secret', admin: true)
user2 = User.create(email: 'stef@gmail.com', password_digest: 'secret', admin: false)
user3 = User.create(email: 'lea@gmail.com', password_digest: 'secret', admin: false)
user4 = User.create(email: 'marie@gmail.com', password_digest: 'secret', admin: false)

Unicorn.create(sex: 'male', unicorn_type: 'fire', color:'red', user: user1)
Unicorn.create(sex: 'female', unicorn_type: 'wind', color:'green', user: user2)
Unicorn.create(sex: 'male', unicorn_type: 'water', color:'blue', user: user3)
Unicorn.create(sex: 'femmale', unicorn_type: 'earth', color:'brown', user: user4)
