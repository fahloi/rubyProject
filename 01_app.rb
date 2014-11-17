require 'sinatra'
require 'sinatra/cookies'

get '/set_language' do
  cookies[:language] = params[:language]
  redirect to('/')
end

get '/' do
  "language: #{cookies[:language]}"
end
