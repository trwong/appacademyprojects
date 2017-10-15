# PHASE 2
def convert_to_int(str)
<<<<<<< HEAD
  Integer(str)
=======
  begin
    Integer(str)
  rescue ArgumentError
    return nil
  end
>>>>>>> refs/remotes/origin/master
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
<<<<<<< HEAD
  else 
    raise StandardError 
  end 
end

def feed_me_a_fruit
=======
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  begin
>>>>>>> refs/remotes/origin/master
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
<<<<<<< HEAD
  reaction(maybe_fruit) 
end  
=======
    reaction(maybe_fruit)
  rescue StandardError
    if maybe_fruit == "coffee"
      retry
    else
      puts "Thats not a fruit!"
    end
  end
end
>>>>>>> refs/remotes/origin/master

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
<<<<<<< HEAD
=======
    raise ArgumentError if yrs_known < 5
    raise ArgumentError if name.length == 0 || fav_pastime.length == 0
>>>>>>> refs/remotes/origin/master
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
<<<<<<< HEAD
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


=======
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
>>>>>>> refs/remotes/origin/master
