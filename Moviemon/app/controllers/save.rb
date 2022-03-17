require "json"

class Save
	attr_reader :slot, :dir
  
	def initialize
		case $view[:save_slot]
		when 0
		  @slot = "a"
		when 1
		  @slot = "b"
		when 2
		  @slot = "c"
		end
		@dir = "#{Rails.root}/app/assets/etc"
	  end

	def self.move_select(direc)
		$view[:save_slot] = $view[:save_slot].to_i if $view[:save_slot].class == String
		case direc
		when 'u'
		  $view[:save_slot] -= 1 if $view[:save_slot] > 0
		when 'd'
		  $view[:save_slot] += 1 if $view[:save_slot] < 2
		end
	end

	def save
		vw = $view.deep_dup
		gm = $game.deep_dup
		pl = $player.deep_dup
		vars = [vw, gm, pl]
		vars.each_entry { |var| var.map { |k, v| var[k] = v.inspect } }
		File.write("#@dir/etc_#@slot.json", "{ \n \"view\" : " + vw.to_json + ", \n", mode: "w")
		File.write("#@dir/etc_#@slot.json", " \"game\" : " +  gm.to_json + ", \n ", mode: "a")
		File.write("#@dir/etc_#@slot.json", " \"player\" : " + pl.to_json + " \n }", mode: "a")
	end
	
	def load
		f = JSON.parse(File.read("#@dir/etc_#@slot.json"))
		$view = f["view"]
		$game = f["game"]
		$player = f["player"]
		vars = [$view, $game, $player]
		vars.each_entry do |var| 
			var.map { |k, v| var[k] = eval(v) }
			var.transform_keys!(&:to_sym) 
		end
	end
	
	def get_movie(name)
		$game[:monsters][$game[:monsters].key(name)]
	end
end
