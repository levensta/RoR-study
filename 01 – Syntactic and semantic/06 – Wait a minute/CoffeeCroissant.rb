#!/usr/bin/ruby -w

def getData
  return [
    ['Frank', 33],
    ['Stacy', 15],
    ['Juan' , 24],
    ['Dom' , 32],
    ['Steve', 24],
    ['Jill' , 24]
  ]
end

def sortData
  data = getData()

  data = data.sort
  data.each { |arr| arr.reverse! }
  data = data.sort
  data.each { |arr| arr.reverse! }
  puts data.to_h.keys()
end

if __FILE__ == $0
  sortData
end