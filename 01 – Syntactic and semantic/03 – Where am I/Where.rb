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

def whereState
  if ARGV.length == 1
    states = getStates()
    captitals = getCapitals()

    if states.include?(ARGV[0])
      puts captitals[states[ARGV[0]]]
    else
      puts "Unknown state"
    end
  end
end

if __FILE__ == $0
  whereState
end