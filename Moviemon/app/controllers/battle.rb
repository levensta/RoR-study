require 'worldmap.rb'

class Battle
	def self.start
		puts "-------Battle begins!-------"
		puts "player hp: #{$player[:hp]}"
		puts "player ap: #{$player[:hit_point]}"
		puts "------"
		puts "moviemon hp: #{$selected[:hp]}"
		puts "moviemon ap: #{$selected[:imdbRating]}"
		puts "----------------------------"
	end

	def self.input_a
		$view[:caption] = ">"

		# Player turn
		$view[:caption] += ">Player attacking! #{$player[:hit_point]} damage to Monster."
		$selected[:hp] -= $player[:hit_point]

		# Victory
		if $selected[:hp] <= 0
			$view[:caption] = ">moviemon caught!"
			$game[:moviedex].append($selected)
			$selected = {}
			$player[:hit_point] = 1 + $game[:moviedex].count
			$player[:hp] = 42
			$game[:input] = "Victory!"
			return '/result'
		end

		# MovieMon turn
		$view[:caption] += ">MovieMon attacking! #{$selected[:imdbRating]} damage to Player."
		$player[:hp] -= $selected[:imdbRating].to_f

		# Defeat
		if $player[:hp] <= 0
			$view[:caption] = ">It's getting dark\nin your eyes..."
			$player[:hp] = 42
			$selected = {}
			print $selected[:Title]
			$game[:input] = "Defeat"
			return '/result'
		end
		return '/battle'
	end

	def self.input_b
		# Player ran away. Spawn monster again
		$player[:hp] = 42
		$view[:caption] = ""
		$view[:caption] += ">you ran away."
		$game[:monsters].insert(0, $selected)
		$selected = {}
		Worldmap.set_one_spawn_point
		return '/result'
	end
end
