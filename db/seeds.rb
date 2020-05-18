# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'yo@gmail.com', admin: true, demand: false, password_digest: BCrypt::Password.create('secret'))

user1 = User.create(email: 'john@gmail.com', admin: true, password_digest: BCrypt::Password.create('secret'))
User.create(email: 'stef@gmail.com', admin: false, demand: true, password_digest: BCrypt::Password.create('secret'))
user2 = User.create(email: 'lea@gmail.com', admin: false, password_digest: BCrypt::Password.create('secret'))
User.create(email: 'marie@gmail.com', admin: false, demand: true, password_digest: BCrypt::Password.create('secret'))

Unicorn.create(sex: 'male', unicorn_type: 'fire', color:'red', user: user1)

Unicorn.create(sex: 'male', unicorn_type: 'water', color:'blue', user: user2)
