# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

artworks = Artwork.create([{ title: 'Star Wars', image_url: "Kyle", artist_id: 4 },
  { title: 'Sunday Morning', image_url: "Taylor", artist_id: 2 },
  { title: 'Sunday Morning', image_url: "Sarah", artist_id: 3 },
  { title: 'Sunday Morning', image_url: "Sarah", artist_id: 3 }])

ArtworkShare.create([{ artwork_id: 1, viewer_id: 2},
  { artwork_id: 2, viewer_id: 3},
  { artwork_id: 2, viewer_id: 4},
  { artwork_id: 2, viewer_id: 4}])
