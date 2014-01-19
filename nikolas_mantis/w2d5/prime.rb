require 'prime'
require 'pry'


  result = ""

  (0..100).each do |x|
    result += "#{x}: "
    if x % 3 == 0
      result += "Pling "
    end
    if x % 5 == 0
      result += "Plang "
    end
    if x % 7 == 0
      result += "Plong "
    end
    result += ","
  end
  puts result
 


