def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score)
    .where(yr: 1980..1989)
    .where(score: 3..5)
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie.select(:yr)
  .group(:yr)
  .having('MAX(score) < 8')
  .pluck(:yr)
  # .where.not('score > 8')
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select(:id, :name)
    .joins(:movies)
    .where('movies.title = (?)', title)
    .order('castings.ord')


end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  # TODO
  Movie.select('movies.id, movies.title, actors.name')
    .joins(:actors)
    .where('director_id = actors.id')
    .where('castings.ord = 1')
    # .joins(:castings)
    # .where('movies.id IS NOT NULL')


end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor.select('name, actors.id, COUNT(actors.id) AS roles')
    .joins(:castings)
    .group('actors.id')
    .order('COUNT(*) DESC')
    .where.not('ord = 1')
    .limit(2)
end
