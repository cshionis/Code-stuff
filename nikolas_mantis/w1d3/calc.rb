require 'pry-byebug'

# Function definitions first
def menu
  # Clear the screen, and present the user with a menu
  puts "***CalcIt***"
  print "(b)asic, (a)dvanced, (m)ortgage, bm(i), (t)rip or (q)uit: "
  @initial_choice = gets.chomp.downcase
end

def basic_calc_option
  print "(a)dd, (s)ubtract, (m)ultiply, (d)ivide: "
  @operation = gets.chomp.downcase
end

def continue
  print "Press Enter"
  z = gets
end

 
def basic_calc
  # ask the user which operation they want to perform
  basic_calc_option

  while @operation != 'a' && @operation !='s'&& @operation != 'm'&& @operation != 'd'
    puts "Please enter a valid input"
    basic_calc_option
  end
 
  # get firsr number
  puts "Enter first number: "
  first_num = gets.chomp.to_f

  # get second number
  puts "Enter second number: "
  second_num = gets.chomp.to_f

  #Act on user choice
  puts case @operation
  when 'a'
    first_num + second_num
  when 's'
    first_num - second_num
  when 'm'
    first_num * second_num
  when 'd'
    first_num / second_num
  end

  # print "Press Enter to continue."
  continue

end #Basic calculator ends

def advanced_calc
  #ask the user which operation they want to perform
  print "(p)ower, (s)quare root: "
  operation = gets.chomp.downcase

  #Ask user for a number
  print "Enter the number: "
  num = gets.chomp.to_f

  #Get the "to the power of" that the user wants
  if operation == 'p'
    print "Enter power: "
    power = gets.chomp.to_i
  end

  #Act on user choice
  puts case operation
  when 'p'
    num ** power
  when 's'
    Math.sqrt(num)
  end
    
  continue

end

#mortgage calculator
def mort_calc

  # Get the necessary input
  print "Please enter the principal amount: "
  principal = gets.chomp.to_f

  print "Please enter the annual interest rate: "
  interest = gets.chomp.to_f

  print "Please enter the number of monthly payments: "
  payments = gets.chomp.to_f

  #convert interest rate to monthly rate
  interest = interest/12/100

  #calculate monthly payment
  result = principal*((interest*(1 + interest)**payments)/((1 + interest)**payments - 1))

  # display result
  puts "Your monthly payment is £" + result.to_s

  continue

end

def check_input_bmi

  print "Do you want (m)etric or (i)mperial? "
  @system = gets.chomp.downcase
end

#Prompt and calculate based on metric system
def metric

  #Prompt user for input
  print "Please enter weight in Kg: "
  mass = gets.chomp.to_f

  print "Please enter height in meters: "
  height = gets.chomp.to_f

  mass/(height**2)
end

#Prompt and calculate based on imperial system
def imperial

  #Prompt user for input
  print "Please enter weight in lb: "
  mass = gets.chomp.to_f

  print "Please enter height in inches: "
  height = gets.chomp.to_f

  703*mass/(height**2)
end

#BMI calculator
def bmi

  #Prompt user for either metric or imperial
  check_input_bmi

  while @system != 'm' && @system !='i'
    puts "Please enter a valid input"
    check_input_bmi
  end

  puts case @system
  when 'm'
    metric
  when 'i'
    imperial
  end

  continue
end

#Promit user to adjust speed
def speed_adjust
  puts "You are driving too fast!"
  print "Please enter a speed less than 80 mph!"
  gets.chomp.to_f
end

#Check if speed is over 60 and adjust mpg
def check_speed(speed, mpg)
  
  # Ask for new speed if too fast
  while speed > 80
    speed = speed_adjust
  end

  # Check if over 60 and adjust mpg
  if speed > 60
    adjustment = (speed - 60)*2
    mpg -= adjustment
  else
    mpg
  end
end


#Trip calculator
def trip

  # Prompt the user for relevant inputs
  print "How far will you drive? (in miles): "
  distance = gets.chomp.to_f

  print "What is the fuel efficiency of the car?: "
  mpg = gets.chomp.to_f

  print "How much does gas cost per gallon?: "
  ppg = gets.chomp.to_f

  print "How fast will you drive?: "
  speed = gets.chomp.to_f

  #Check if speed is over 60 and adjust mpg
  mpg = check_speed(speed, mpg)

  if mpg <= 0
    puts "Your mpg is either negative or zero..Try again!"
  else
    #calculate time needed
    time = distance/speed

    #calculate fuel cost
    fuel_cost = distance/mpg*ppg

    puts "Your trip will take #{time} hours and cost $#{fuel_cost}."
  end

  continue

end

 
# run the app...
puts `clear`
menu

# Check user input
while @initial_choice != 'q' && @initial_choice != 'b' && @initial_choice != 'a' && @initial_choice != 'm' && @initial_choice != 'i' && @initial_choice != 't'
  puts "Please enter a valid input"
  menu
end
 
while @initial_choice != 'q'
  case @initial_choice
  when 'b'
    basic_calc
  when 'a'
    advanced_calc
  when 'm'
    mort_calc
  when 'i'
    bmi
  when 't'
    trip
  end
 
  menu
end