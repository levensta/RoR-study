#!/usr/bin/ruby -w

def my_variables(a, b, c, d)
  vars = {
    "a" => a,
    "b" => b,
    "c" => c,
    "d" => d
  }

  puts "my variables :"
  vars.each do |key, val|
    puts "\t#{key} contains: " +
    (val.is_a?(NilClass) ? val.inspect : val.to_s) +
    " and is a type: #{val.class}"
  end
  
end
  
  
if __FILE__ == $0
  my_variables(10, "10", nil, 10.0)
end