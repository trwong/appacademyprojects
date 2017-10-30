# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
COLORS = %w(black white calico orange gray brown).freeze

3.times do
  Cat.create(name: Faker::Superhero.name, sex: ["M", "F"].sample, birth_date: '2010/01/21', color: COLORS.sample, description: Faker::StarWars.quote)
end

CatRentalRequest.create(cat_id: 1, start_date: '2000/01/01', end_date: '2001/01/01', status: 'APPROVED')
CatRentalRequest.create(cat_id: 1, start_date: '1998/01/01', end_date: '2000/06/04', status: 'PENDING')
CatRentalRequest.create(cat_id: 2, start_date: '1998/01/01', end_date: '2000/06/04', status: 'APPROVED')
CatRentalRequest.create(cat_id: 1, start_date: '2002/01/01', end_date: '2003/01/01', status: 'APPROVED')
CatRentalRequest.create(cat_id: 1, start_date: '2004/01/01', end_date: '2005/01/01', status: 'APPROVED')
