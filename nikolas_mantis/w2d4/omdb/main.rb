require 'pry-byebug'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'httparty'
require 'json'
require 'pg'

get '/' do
  
  # @movies = run_sql("SELECT * FROM movies")

  erb :index
end

get '/actors' do

  @actors = run_sql("SELECT * FROM actors")

  erb :actors
end 

get '/search_actors' do

end

get '/new_actor' do

  erb :new_actor

end

post '/create_actor' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  dob = params[:dob]
  image = params[:image]

  run_sql("INSERT INTO actors (first_name, last_name, dob, image_url) VALUES ('#{first_name}','#{last_name}','#{dob}','#{image}')")

  redirect to('/actors')
end

get '/show_actor/:id' do

  sql = "SELECT * FROM actors WHERE id=#{params[:id]}"
  @actor_by_id = run_sql(sql).first

  erb :show_actor

end

get '/edit_actor/:id' do

  sql = "SELECT * FROM actors WHERE id=#{params[:id]}"
  @edit_actor = run_sql(sql).first

  erb :edit_actor

end

post '/update_actor/:id' do

  first_name = params[:first_name]
  last_name = params[:last_name]
  dob = params[:dob]
  image = params[:image]

  run_sql("UPDATE actors SET first_name='#{first_name}', last_name='#{last_name}', dob='#{dob}', image_url='#{image}'  WHERE id=#{params[:id]}") 

  redirect to("/show_actor/#{params[:id]}")

end

get '/delete_actor/:id' do

  sql = "DELETE FROM actors WHERE id=#{params[:id]}"
  run_sql(sql)

  redirect to('/actors')

end

post '/search_actors' do

  actor = params[:search_actors]

  sql = "SELECT * FROM actors WHERE first_name LIKE '%#{actor}%' OR last_name LIKE '%#{actor}%'"
  @actors = run_sql(sql)
  if @actors.first
  puts @actors.first
end
  erb :search_actors

end

get '/movies' do
  @movies = run_sql("SELECT * FROM movies")

  erb :movies
end

get '/find' do

  movie = params[:movie]
  # movie = "shrek"
  movie.gsub!(' ', '+')

  url = "http://www.omdbapi.com/?t=#{movie}"
  html = HTTParty.get(url)
  hash = JSON(html)
  
  sql = "INSERT INTO movies (title, poster, year, rated, released, runtime, genre, director, writers, actors, plot) VALUES ('#{hash['Title']}', '#{hash['Poster']}', '#{hash['Year']}', '#{hash['Rated']}', '#{hash['Released']}', '#{hash['Runtime']}', '#{hash['Genre']}', '#{hash['Director']}', '#{hash['Writer']}', '#{hash['Actors']}', '#{hash['Plot']}')"

  run_sql(sql)

  redirect to('/movies')
end






def run_sql(sql)

  conn = PG.connect(dbname: 'movies', host: 'localhost')

  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end

  result
end