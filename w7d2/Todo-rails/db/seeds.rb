# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Todo.destroy_all
Todo.create(title: "Buy milk", body: "2% or w/e", done: false)
Todo.create(title: "Feed the cats", body: "2% or w/e", done: true)
Todo.create(title: "Redistribute the wealth", body: "2% or w/e", done: false)
