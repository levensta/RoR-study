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

def whereTo
  if ARGV.length == 1
    states = getStates()
    captitals = getCapitals()
    delimiters = [',', ' '];

    localities = ARGV[0].split(Regexp.union(delimiters))
    .reject(&:empty?).map(&:capitalize)

    localities.each do |item|
      if captitals.key(item)
        city = item
        state = states.key(captitals.key(item))
      elsif states.include?(item)
        state = item
        city = captitals[states[item]]
      end

      if city && state
        puts city + " is the capital of " + state + " (akr: " + states[state] + ")"
      else
        puts item + " is neither a capital city nor a state"
      end
    end
  end
end

if __FILE__ == $0
  whereTo
end