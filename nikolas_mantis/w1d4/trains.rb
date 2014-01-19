#############    General prompt and calculations    ############
def prompt
  print "Please enter the " + yield
  gets.chomp
end

#----------#

#Calculates distance on a single line
def distance (hash, dep_station, line, intersect)
  # line = hash.fetch(line.to_sym)
  stops = line.each_index.select{|i| line[i] == intersect}.join.to_i - line.each_index.select{|i| line[i] == dep_station}.join.to_i 
  if stops < 0
    return -stops
  else
    return stops
  end
end


#-------------------------------------------------------#


############     Get lines and stations through block ###########

def get_valid_dep_line
  # Get input for departure line
  @dep_line = prompt {"departure train line (n, l, s): "}
end

#----------#

def get_valid_arr_line
  ## Get input for arrival line
  @arr_line = prompt {"arrival train line (n, l, s): "}
end

#----------#

def get_valid_dep_station

  ## Get input for departure station
  case @dep_line
    when 'q'
      @exit = 'q'
    when 'n'
      @dep_station = prompt {"departure station name (ts, 34th, 28th-n, 23rd-n, us, 8th-n): "}
    when 'l'
      @dep_station = prompt {"departure station name (8th-l, 6th, us, 3rd, 1st): "}
    when 's'
      @dep_station = prompt {"departure station name (gc, 33rd, 28th-s, 23rd-s, us, ap): "}
    end
end

#----------#

def get_valid_arr_station

  ## Get input for departure station
  case @arr_line
    when 'q'
      @exit = 'q'
    when 'n'
      @arr_station = prompt {"arrival station name (ts, 34th, 28th-n, 23rd-n, us, 8th-n): "}
    when 'l'
      @arr_station = prompt {"arrival station name (8th-l, 6th, us, 3rd, 1st): "}
    when 's'
      @arr_station = prompt {"arrival station name (gc, 33rd, 28th-s, 23rd-s, us, ap): "}
    end
end

#----------------------------------------------------------------------------------#

##############    

def check_station_dep
   while !$hash.fetch(@dep_line.to_sym).include? (@dep_station)
        puts "Please enter a valid station"
        get_valid_dep_station
      end
end

def check_station_arr
   while !$hash.fetch(@arr_line.to_sym).include? (@arr_station)
        puts "Please enter a valid station"
        get_valid_arr_station
      end
end

#-------------------------------------------------------------------------------#

#########    Dep's and Arr's main functions    #####################

def get_departure

  get_valid_dep_line

  while @dep_line != 'n' && @dep_line != 'l' && @dep_line != 's' && @dep_line != 'q'
    puts "Please enter a valid train line"
    get_valid_dep_line
  end

  ## Get input for departure station
  get_valid_dep_station
  case @dep_line
    when 'q'
      @exit = 'q'
    else
      check_station_dep
    end
end
#--------#

def get_arrival

  get_valid_arr_line

  while @arr_line != 'n' && @arr_line != 'l' && @arr_line != 's' && @arr_line != 'q'
    puts "Please enter a valid train line"
    get_valid_arr_line
  end

  get_valid_arr_station
  # Get input for arrival station
  case @arr_line
    when 'q'
      @exit = 'q'
    else
      check_station_arr
    end

end

#####################     START     ##################

exit = 'a'


$hash = {n: ["ts", "34th", "28th-n", "23rd-n", "us", "8th-n"],
        l: ["8th-l", "6th", "us", "3rd", "1st"],
        s: ["gc", "33rd", "28th-s", "23rd-s", "us", "ap"]}

#Run the program as a loop
while exit != 'q'

  intersect = 0

  get_departure
  
  exit = @exit
  
  if exit != 'q'
    get_arrival
  end

  exit = @exit

  if exit != 'q'
    # If the two lines are the same
    if @dep_line == @arr_line

      # Get the line and calculate distance
      line = $hash.fetch(@dep_line.to_sym)
      stops = distance(hash, @dep_station, line, @arr_station)
      puts "You trip is #{stops} stops long!" 

    # If two separate lines
    elsif exit != 'q'
      # Get the two arrays from the lines
      line1 = $hash.fetch(@dep_line.to_sym)
      line2 = $hash.fetch(@arr_line.to_sym)

      # Get the intersection point and convert to string
      intersect = (line1 & line2).join

      # Get the distance that will be covered on each line
      trip1 = distance($hash, @dep_station, line1, intersect)
      trip2 = distance($hash, intersect, line2, @arr_station)

      puts puts "You trip is #{trip1 + trip2} stops long!"
    end
  end

end