class Worldmap
	def self.move_char(direc)
		case direc
		when 'u'
		  $game[:pos][:y] -= 1 if $game[:pos][:y] > 0 && $game[:spawn][$game[:pos][:x]][$game[:pos][:y] - 1] != 9
		when 'd'
		  $game[:pos][:y] += 1 if $game[:pos][:y] < 9 && $game[:spawn][$game[:pos][:x]][$game[:pos][:y] + 1] != 9
		when 'r'
		  $game[:pos][:x] += 1 if $game[:pos][:x] < 9 && $game[:spawn][$game[:pos][:x] + 1][$game[:pos][:y]] != 9
		when 'l'
		  $game[:pos][:x] -= 1 if $game[:pos][:x] > 0 && $game[:spawn][$game[:pos][:x] - 1][$game[:pos][:y]] != 9
		end
		x = $game[:pos][:x]
		y = $game[:pos][:y]
		here = $game[:spawn][x][y]
		if here == 1
			$game[:spawn][x][y] = 0
			return 1
		elsif here == 2
			$game[:spawn][x][y] = 0
			$view[:new_ball] = 2
			$player[:movieballs] += 1
			return 2
		end
		return 0
	end

	def self.set_spawn_points
		wall = [
			[0, 0], [0, 1], [0, 3], [0, 4], [0, 5], [0, 8], [0, 9],
			[1, 6], [1, 7],
			[3, 6], [3, 7], [4, 6], [4, 7], [5, 6], [5, 7], [6, 6], [6, 7],
			[8, 6], [8, 7], [9, 6], [9, 7],
			[5, 9], [9, 5],
			[6, 0], [6, 1], [6, 2], [6, 3],
			[7, 0], [7, 1], [7, 2], [7, 3],
			[8, 0], [8, 1], [8, 2], [8, 3],
		]

		wall.each { |w|
			$game[:spawn][w[0]][w[1]] = 9
		}

		$game[:spawn].each { |x|
			nums = [0,1,2,3,4,5,6,7,8,9]
			x.each.with_index { |n, i|
				nums.delete(i) if n == 9
			}
			y1 = nums.delete_at(rand(nums.length))
			y2 = nums.delete_at(rand(nums.length))
			x[y1] = 1
			x[y2] = 1
		}

		candidate_ball = []
		10.times { |x_index|
			candidate_ball[x_index] = []
			$game[:spawn][x_index].each.with_index { |y_value, y_index| 
				candidate_ball[x_index].push(y_index) if y_value == 0
			}
		}
		5.times { 
			x = rand(10)
			y = candidate_ball[x][rand(candidate_ball[x].length)]
			$game[:spawn][x][y] = 2
		}
	end

	def self.set_one_spawn_point
		$game[:spawn].each { |x|
				x.each { |y| y = 1 if y == 0
				return
			}
		}
	end
end
