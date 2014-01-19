require 'pry-byebug'

class Person

  attr_accessor :id, :name, :age, :gender, :kids, :pets

  def initialize(args={})
    @id = args.fetch(:id)
    @name = args.fetch(:name)
    @age = args.fetch(:age)
    @gender = args.fetch(:gender)
    @kids = args.fetch(:kids, "")
    @pets = args.fetch(:pets, [])
    if @pets != []
      @pets = @pets.split(',')
    end
  end

end

class Animal

  attr_accessor :name, :age, :gender, :breed, :toys, :adoption

  def initialize(args={})
    @name = args.fetch(:name)
    @age = args.fetch(:age)
    @gender = args.fetch(:gender)
    @breed = args.fetch(:breed)
    @toys = args.fetch(:toys, [])
    if @toys != []
      @toys = @toys.split(',')
    end
    @adoption = args.fetch(:adoption, "Yes")
  end

end

class Shelter
  attr_accessor :name, :animals, :clients

  def initialize(args={})
    @name = args.fetch(:name)
    @animals = args.fetch(:animals, {})
    @clients = args.fetch(:clients, {})
  end

end

#------------------------------------------------------------#

#**************** FUNCTIONS **************************#

#Lists all clients registered with the shelter
def list_all_clients(shelter)
  if shelter.clients.any?
    shelter.clients.each do |key, x|
      puts "ID: #{key}, Name: #{x.name}, Age: #{x.age}, Gender: #{x.gender}, Kids: #{x.kids}, Pets: #{x.pets.join(', ')}"
    end
  else
    puts "We have no clients left! We need to rethink our strategy!"
  end
end

#Lists all animalsq registered with the shelter
def list_all_animals(shelter)

  if shelter.animals.any?
    puts "*** List of all animals ***"
    shelter.animals.each do |key, x|
      puts "Name: #{x.name}, Breed: #{x.breed}, Gender: #{x.gender}, Age: #{x.age}, Toys: #{x.toys.join(', ')}, Adoption: #{x.adoption}"
    end
  else
    puts "We have no animals left!"
  end

end

#Lists all animals available for adoption
def adoption_list(shelter)

  if shelter.animals.any?
    puts "*** List of animals available for adoption ***"
    shelter.animals.each do |key, x|
      if x.adoption == "y"
        puts "Name: #{key}, Breed: #{x.breed}, Gender: #{x.gender}, Age: #{x.age}, Toys: #{x.toys.join(', ')}, Adoption: #{x.adoption}"
      end
    end
  else
    puts "We have no animals left!"
  end

end

#Registers a new pet and adds it to shelter register
def give_animal(shelter, animal)

  puts "***Pet's registration details***"
  animal.name = prompt {"Enter pet's name:"}

  animal.age = prompt {"Enter pet's age:"}

  animal.gender = validate_simple_input(%w(m f)) {prompt {"Enter pet's gender: (m , f)"}}
  
  if animal.gender != 'q' 
    animal.breed = prompt {"Enter pet's breed:"}

    toys = prompt {"Enter pet's toys: (separate with a comma)"}
    animal.toys << toys.split(',')
   
    animal.adoption = validate_simple_input(%w(y n)) {prompt {"For adoption? (y , n)"}}

    if animal.adoption != 'q'
      shelter.animals[animal.name] = animal
    else
      puts "Abort. Try agiain."
    end

  else
    puts "Abort. Try agiain."
  end

end

#Prompt the user for input
def prompt
  print yield
  gets.chomp
end

#Validate simple characters
def validate_simple_input(input)
  value = yield
  until input.include?(value)
    puts "Invalid value. ('q' to exit)"
    value = yield
    if value == 'q'
      return value
    end
  end
  value
end

#Validates hash keys
def validate_input(a_hash)
  value = yield
  until a_hash.has_key?(value)
    puts "#{value}"
    puts "Invalid value."
    value = yield
    if value == 'q'
      return value
    end
  end
  value
end

#Adopt a pet - deletes pet from shelter register
def adopt_pet(shelter)

  puts "*** Adopt a pet ***"
  puts "Please select user:"
  if shelter.clients.any?
    shelter.clients.each do |key, x|
      puts "ID: #{key}, Name: #{x.name}"
    end   
    user_id = validate_input(shelter.clients) {prompt {"Enter user ID: "}}
    puts
    name = validate_input(shelter.animals) {prompt {"Enter the name of the pet you want to adopt: "}}
    if name != 'q'
      shelter.clients.fetch(user_id).pets << shelter.animals.fetch(name).name
      shelter.animals.delete(name)
      puts "You have a new pet!!"
      puts "***Pet removed***"
    end
  else
    puts "We have no clients left! We need to rethink our strategy!"
  end
  
end

#Registers a new client and adds it to shelter register
def add_client(shelter, client)
  puts "*** Client registration form ***"
  client.id = prompt {"ID number:"}
  client.name = prompt {"Name:"}
  client.age = prompt {"Age:"}
  client.gender = validate_simple_input(%w(m f)) {prompt {"Gender (m , f):"}}
  #Break if user wants to quit
  if client.gender != 'q'
    client.kids = prompt {"Number of kids:"}
    client.pets = prompt {"Other pets:"}
    if client.pets != 'n'
      client.pets = client.pets.split(',')
    end

    shelter.clients[client.id] = client
  else
    puts "Registration aborted."
  end
end

#Functionality to edit an animal
def edit_animal(shelter)

  #Show the user the list of all animals
  list_all_animals(shelter)
  
  #Ask user for the name of the animal and validate that animal exists
  value = validate_input(shelter.animals) {prompt {"Enter the name of the animal you want to edit: "}}
  puts

  #Unless user wants to exit
  if value != 'q'

    #Store animal to a new variable
    animal = shelter.animals[value]

    #Ask user for the value they want to edit
    puts "Name: #{animal.name}, Breed: #{animal.breed}, Gender: #{animal.gender}, Age: #{animal.age}, Toys: #{animal.toys.join(', ')}, Adoption: #{animal.adoption}"
    puts
    puts "What to you want to edit?"

    #Get user input and validate
    choice = validate_simple_input(%w(n b g a t d)) {prompt {"(n)ame, (b)reed, (g)ender, (a)ge, (t)oys, a(d)option: "}}
    if choice != 'q'
      case choice

      #Edit name
      when 'n'
        res = prompt {"Enter new name: "}   #Get new name
        animal.name = res                   #Store the name into new animal variable
        shelter.animals.store(res, animal)  #Insert new animal into animals hash
        shelter.animals.delete(value)       #Remove animal with old name
        animal = shelter.animals[res]       #Assign the animal variable for all animal properties
      when 'b'
        #Get user input and assign changed value to hash
        shelter.animals[value].breed = prompt {"Enter new breed: "}
      when 'g'
        #Get user input, validate, and assign changed value to hash
        res = validate_simple_input(%w(m f)) {prompt {"Enter new gender (m , f): "}}
        if res != 'q'
          shelter.animals[value].gender = res
        end
      when 'a'
        #Get user input and assign changed value to hash
        shelter.animals[value].age = prompt {"Enter new age: "}
      when 't'
        #Get user input and assign changed value to hash
        shelter.animals[value].toys << prompt {"Enter new toy: "}
      when 'd'
        #Get user input, validate, and assign changed value to hash
        res = validate_simple_input(%w(y n)) {prompt {"Enter new adoption status (y , n): "}}
        if res != 'q'
          shelter.animals[value].adoption = res
        end
      end
    end
    puts "Edit completed"
    # Output new animal
    puts "Name: #{animal.name}, Breed: #{animal.breed}, Gender: #{animal.gender}, Age: #{animal.age}, Toys: #{animal.toys.join(', ')}, Adoption: #{animal.adoption}"
  else
    puts "Aborted"
  end
  
end

#Edit an existing user
def edit_user(shelter)

  #Show the user the list of all animals
  list_all_clients(shelter)
  
  #Ask user for the name of the animal and validate that animal exists
  value = validate_input(shelter.clients) {prompt {"Enter the ID of the client you want to edit: "}}
  puts

  #Unless user wants to exit
  if value != 'q'

    #Store animal to a new variable
    client = shelter.clients[value]

    #Ask user for the value they want to edit
    puts "Name: #{client.name}, ID: #{client.id}, Gender: #{client.gender}, Age: #{client.age}, Pets: #{client.pets.join(', ')}, Kids: #{client.kids}"
    puts
    puts "What to you want to edit?"

    #Get user input and validate
    choice = validate_simple_input(%w(n i g a p k)) {prompt {"(n)ame, (i)d, (g)ender, (a)ge, (p)ets, (k)ids: "}}
    if choice != 'q'
      case choice

      #Edit name
      when 'n'
        shelter.clients[value].name = prompt {"Enter new name: "}
        
      when 'i'
        #Get user input and assign changed value to hash
        res = prompt {"Enter new id: "}   #Get new name
        client.id = res                   #Store the name into new animal variable
        shelter.clients.store(res, client)  #Insert new animal into animals hash
        shelter.clients.delete(value)       #Remove animal with old name
        client = shelter.clients[res]       #Assign the animal variable for all animal properties
      when 'g'
        #Get user input, validate, and assign changed value to hash
        res = validate_simple_input(%w(m f)) {prompt {"Enter new gender (m , f): "}}
        if res != 'q'
          shelter.clients[value].gender = res
        end
      when 'a'
        #Get user input and assign changed value to hash
        shelter.clients[value].age = prompt {"Enter new age: "}
      when 'p'
        #Get user input and assign changed value to hash
        shelter.clients[value].pets << prompt {"Enter new pet: "}
      when 'k'
        #Get user input, validate, and assign changed value to hash
        shelter.clients[value].kids = prompt {"Enter new num of kids: "}
      end
    end
    puts "Edit completed"
    # Output new animal
    puts "Name: #{client.name}, Breed: #{client.id}, Gender: #{client.gender}, Age: #{client.age}, Pets: #{client.pets.join(', ')}, Kids: #{client.kids}"
  else
    puts "Aborted"
  end

end

#------------ MAIN ----------------------------#

#Some initial data
shelter = Shelter.new(name: "Happy Puppy")
c1 = Person.new(id: "1", name: "nikos", age: "30", gender: "m", pets: "dog", kids: "2")
a1 = Animal.new(name: "Miss Pussy", breed: "cat", gender: "f", age: "3", adoption: "y")
a2 = Animal.new(name: "Snoop Dogg", breed: "dog", gender: "m", age: "5", adoption: "n")
shelter.animals[a1.name] = a1
shelter.animals[a2.name] = a2
shelter.clients[c1.id] = c1

#Shows user the main menu
def get_response(name)
  puts `clear`
  puts "*** Welcome to #{name} ****"
  puts "Please select one of the choices below."
  print "a(d)d user, (l)ist of all animals, (g)ive animal, (a)doption a pet, (c)lient list, (e)dit animal, edit (u)ser, (q)uit: "
  gets.chomp.downcase
end

response = get_response(shelter.name)

#Run until user types 'q'
while response != 'q'

  case response
  when 'l'
    list_all_animals(shelter)
  when 'g' #User wants to give animal

    #First ask the user to register if he is not
    new_client = validate_simple_input(%w(y n)) {prompt {"New Customer? (y , n)"}}
    if new_client == 'y'
      client = Person.new(id: "", name: "", age: "", gender: "", kids: "", pets: "")
      add_client(shelter, client)
    end

    #Then create a new animal based on user input
    animal = Animal.new(name: "", age: "", gender: "", breed: "")
    give_animal(shelter, animal)
  when 'a'
    
    #Check if shelter has animals
    if shelter.animals.any? 
      #Display adoption list to user
      adoption_list(shelter)
      #Ask user to proceed or not
      ready = validate_simple_input(%w(y n)) {prompt {"Ready to adopt? (y , n)"}}
      #When user is ready to adopt
      if ready == 'y'
        adopt_pet(shelter)
      end
    else
      puts "We have no animals left!"
    end
  when 'c'
    list_all_clients(shelter)
  when 'e'
    edit_animal(shelter)
  when 'd'
    client = Person.new(id: "", name: "", age: "", gender: "", kids: "", pets: "")
    add_client(shelter, client)
  when 'u'
    #Edit user
    edit_user(shelter)
  else
    puts "Please enter a valid choice"
  end

  puts "Press Enter to continue"
  gets

  response = get_response(shelter.name)

  #binding.pry

end






