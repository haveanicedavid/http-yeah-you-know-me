class Game
	attr_reader :status, :user_guesses, :guess_count

	def initialize()
		@status = "Game has not been started!"
		@secret = 10
		# @secret = rand(100)
		@user_guesses = []
		@guess_count = 0
	end


	def guess(num)
		@guess_count += 1
		if num > @secret
			@status = "Your guess, #{num}, was too high. You've taken #{guess_count} guesses"
		elsif num < @secret
			@status = "Your guess, #{num}, was too low. You've taken #{guess_count} guesses."
		else
			@status = "#{num} was correct! You Won in #{guess_count} guesses"
		end
	end

	## NOTE
	### This is how you'd do the above with a case statement. Google the <=> operator
	# def guess(num)
	# 	@guess_count += 1
	# 	case num <=> @secret
	# 	when -1
	# 		@status = "Your guess, #{num}, was too low. You've taken #{guess_count} guesses."
	# 	when 1
	# 		@status = "Your guess, #{num}, was too high. You've taken #{guess_count} guesses"
	# 	when 0
	# 		@status = "#{num} was correct! You Won in #{guess_count} guesses"
	# 	end
	# end

end
