require 'pry'

puts "Welcome to Number Guess"
puts "What is your name or nickname?"

input = gets
name = input.chomp

puts "Welcome, #{nickname}. I'm thinking of a number. Can you guess it?"

#post to start_game, begins the game, says Good luck!, starts a game

num = rand(1..100) #does rand(101) mean the same?
number_of_guesses = 0

got_it = false

until number_of_guesses == 100 or got_it

  puts "There are #{100 - number_of_guesses} guesses left."
  print "Make a guess: "
  guess = gets.to_i

  number_of_guesses += 1

  if guess < num
    puts "Whoops, guess was too low."
  elsif guess > num
    puts "Whoops, guess was too high."
  elsif guess == num
    puts "Well, SHIT #{name}!"
    puts "It only took you #{number_of_guesses} to get my number."
    got_it = true
    end

end

#for dumbasses who guess the same number twice
unless got_it
  puts "Oh well. You did not guess my number. It was #{num}. Why would you guess the same number twice?"
end



    






