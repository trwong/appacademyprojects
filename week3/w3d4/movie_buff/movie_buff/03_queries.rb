def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .group('movies.id')
    .having('COUNT(*) = ?', those_actors.length)



  # movies = Movie
  #   .select('*')
  #   .joins(:actors)
  #   .where('actors.name = ?', those_actors.first)
  #
  # result = []
  # movies.each do |movie|
  #   result << {'id' => movie.id, 'title' => movie.title} if those_actors.all? do |actor|
  #     Casting
  #       .joins(:actor)
  #       .where('castings.movie_id = ?', movie.id)
  #       .where('actors.name = ?', actor)
  #       .length == those_actors.length
  #   end
  # end
  # result
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
  .select('yr / 10 * 10')
  .group('yr / 10 * 10')
  .order('AVG(score) DESC')
  .limit(1)
  .pluck('yr / 10 * 10').first
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  actors_movies = Movie
    .select(:title)
    .joins(:actors)
    .where('actors.name = ?', name)
    .where('actors.id = castings.actor_id')
    .where('castings.movie_id = movies.id')

  Actor
    .select(:name)
    .joins(:movies)
    .where('movies.title IN (?)', actors_movies)
    .where.not('actors.name = ?', name).distinct
    .pluck('actors.name')

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
  .select('COUNT(actors.id)')
  .joins('LEFT JOIN castings ON actors.id = castings.actor_id')
  .where('castings.actor_id IS NULL')
  .pluck('COUNT(actors.id)').first
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .select("actors.id, name, MAX(movies.yr) - MIN(movies.yr) AS career")
    .joins(:movies)
    .group('actors.id')
    .order('MAX(movies.yr) - MIN(movies.yr) DESC, actors.name ASC')
    .limit(3)
end
