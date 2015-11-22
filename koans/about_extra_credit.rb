# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.




class Player
 	attr_accessor :currentTotal, :active
 	def initialize
 		@active = false
 		@currentTotal = 0
 	end
end


class Game
	attr_accessor :players
	attr_accessor :currentWinner
	def initialize
		@currentWinner = {0=>0}
	end 

	def roll(number)
		values = []
		(0...number).each {values << rand(1..6)}
		values
	end


	def score(dice)
		dices = 0
		score = 0
		result = {1=>0,2=>0,3=>0,4=>0,5=>0,6=>0} 
		dice.each do |temp|
			result[temp] += 1
			temp_count = result[temp]
			score += temp*100 if temp_count == 3 unless temp == 1 || temp == 5
			score += 800 if temp_count == 3 && temp == 1
			score += 400 if temp_count == 3 && temp == 5
			score += 100 if temp == 1 unless temp_count == 3
			score += 50 if temp == 5 unless temp_count == 3
		end
		[2,3,4,6].each do |x|
			dices += result[x]%3
		end
		dices = dice.length if dices == 0 
		return score, dices  
	end



    
    def start 
    	@players = {}
    	print "How many players are playing - "
		num_of_players = gets.chomp
		puts "Initializing players, please wait ..."
		(1..num_of_players.to_i).each {|num| @players[num] = Player.new}
		breached3000 = false
		while not breached3000
			breached3000 = round
			if breached3000
				round
			end
		end
		puts "Hurray player : #{@currentWinner.keys[0]} wins"
	end
	
	


	def round
		breached3000 = false
		@players.keys.each do |currentPlayer|
			turnScore = 0
			dices = 5
			rollMore = true
			while rollMore
				puts "player : #{currentPlayer}"
				puts "You have #{dices} dices"
				print "Type 'no' to pass, type 'roll' to roll - "
				decesion = gets.chomp
				if decesion == 'no'
					rollMore = false
				elsif decesion == 'roll'
					rollResult = roll(dices)
					rollScore, dices = score(rollResult)
					if rollScore == 0
						turnScore = 0
						rollMore = false
					else
						turnScore += rollScore
					end
				else 
					puts "Invalid command"
				end
				puts "Your roll produced following result:"
				print rollResult
				puts "  with a score of #{rollScore}"
				puts " This turn's score is #{turnScore}"
			end

			if turnScore >= 300 
				@players[currentPlayer].currentTotal += turnScore
				@players[currentPlayer].active = true
			elsif turnScore < 300 && players[currentPlayer].active
				@players[currentPlayer].currentTotal += turnScore
			end
			puts " Your this round's score is #{turnScore}"
			puts " Your total score now is #{@players[currentPlayer].currentTotal}" 
			if @players[currentPlayer].currentTotal >= 600
				breached3000 = true
			end
			if @players[currentPlayer].currentTotal > @currentWinner.values[0]
				@currentWinner = {currentPlayer => @players[currentPlayer].currentTotal}
			end
		end
		return breached3000

	end

end



game = Game.new
game.start
