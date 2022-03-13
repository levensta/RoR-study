#!/usr/bin/ruby -w

def getData
  return [
    ['Caleb' , 24],
    ['Calixte' , 84],
    ['Calliste', 65],
    ['Calvin' , 12],
    ['Cameron' , 54],
    ['Camil' , 32],
    ['Camille' , 5],
    ['Can' , 52],
    ['Caner' , 56],
    ['Cantin' , 4],
    ['Carl' , 1],
    ['Carlito' , 23],
    ['Carlo' , 19],
    ['Carlos' , 26],
    ['Carter' , 54],
    ['Casey' , 2]
  ]
end

def dataToHash
  data = getData()

  data.each { |arr| arr.reverse! }

  h = data.to_h
  h.each do |key, val|
    puts key.to_s + " : " + val.to_s
  end

end

if __FILE__ == $0
  dataToHash
end