require 'pry-byebug'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/' do
  erb :home
end

get '/calc' do

  @first = params[:first].to_f
  @operator = params[:operator]
  @second = params[:second].to_f

  @result = case @operator
  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then  @first * @second
  when '/' then  @first / @second
  end

  erb :calc
end

get '/calc_advanced' do

  @num = params[:num]
  @power = params[:power]
  @num_sqrt = params[:num_sqrt]

  erb :calc_advanced

end

get '/mortgage' do

  @principal = params[:principal]
  @interest = params[:interest]
  @payments = params[:payments]
    
  erb :mortgage
end

get '/bmi' do

  @weight_kg = params[:weight_kg]
  @height_kg = params[:height_kg]
  @weight_p = params[:weight_p]
  @height_p = params[:height_p]

  erb :bmi
end

get '/trip' do

  @distance = params[:distance]
  @mpg = params[:mpg]
  @ppg = params[:ppg]
  @speed = params[:speed]

  erb :trip
end


