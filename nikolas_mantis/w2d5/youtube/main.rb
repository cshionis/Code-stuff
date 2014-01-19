require 'pry-byebug'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'dbconn'
include DBconn



post '/' do

  video = params[:search_videos]

  @genres = get_genres
  sql = "SELECT * FROM videos WHERE title LIKE '%#{video}%' OR description LIKE '%#{video}%' OR genre LIKE '%#{video}%'"
  @videos = run_sql(sql)

  erb :index

end

get '/' do
  @videos = run_sql('SELECT * FROM videos')
  @genres = get_genres
  erb :index
end

get '/new_video' do

  @genres = get_genres
  erb :new_video
end

post '/create_video' do

  #Run external DB module method to check values and insert to DB
  run_sql_args(["#{params[:title]}", "#{params[:genre]}", "#{params[:url]}", "#{params[:description]}"], 'i')

  redirect to('/')
end

get '/show_video/:id' do

  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @video_by_id = run_sql(sql).first
  @genres = get_genres

  erb :show_video

end

get '/edit_video/:id' do

  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @edit_video = run_sql(sql).first
  @genres = get_genres

  erb :edit_video

end

post '/update_video/:id' do

  #Run external DB module method to check values and insert to DB
  run_sql_args(["#{params[:title]}", "#{params[:genre]}", "#{params[:url]}", "#{params[:description]}", "#{params[:id]}"], 'u')

  redirect to("/show_video/#{params[:id]}")

end

get '/delete_video/:id' do

  sql = "DELETE FROM videos WHERE id=#{params[:id]}"
  run_sql(sql)

  redirect to('/')

end

get '/show_genre/:genre' do

  sql = "SELECT * FROM videos WHERE genre='#{params[:genre]}'"
  @videos_by_genre = run_sql(sql)
  @genres = get_genres

  erb :show_genre

end

def get_genres
  run_sql('SELECT genre FROM videos GROUP BY genre')
end



