#!/usr/bin/ruby -w

def f
  file_path = File.dirname(__FILE__) + "/numbers.txt"

  file = IO.read(file_path)
  arrNums = file.split(",\n").map(&:to_i).sort

  puts arrNums

end

if __FILE__ == $0
  f
end