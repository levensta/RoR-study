#!/usr/bin/ruby -w

def getStates
  return {
    "Oregon" => "OR",
    "Alabama" => "AL",
    "New Jersey" => "NJ",
    "Colorado" => "CO"
  }
end

def getCapitals
  return {
  "OR" => "Salem",
  "AL" => "Montgomery",
  "NJ" => "Trenton",
  "CO" => "Denver"
}
end

def whereCapital
  if ARGV.length == 1
    states = getStates()
    captitals = getCapitals()

    if captitals.key(ARGV[0])
      puts states.key(captitals.key(ARGV[0]))
    else
      puts "Unknown capital city"
    end
  end
end

if __FILE__ == $0
  whereCapital
end