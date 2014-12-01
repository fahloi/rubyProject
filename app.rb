require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'dm-sqlite-adapter'
#
enable :sessions
use Rack::Flash
#
DataMapper.setup(:default, 'sqlite:///Users/r00t/Documents/test.db')
#
class User
    include DataMapper::Resource
    property :id,       Serial
    property :name,     String
    property :password, BCryptHash
end
#
get '/register' do
    erb :register
end
#
post '/register' do
    u = params[:name]
    p = params[:pwrd]
    p2 = params[:pwrd2]
    #
    if p != p2
        flash[:errorMessage] = "Passwords don't match"
        redirect '/register'
    else
        User.create(name: u, password: p)
        flash[:msg] = 'Hallo ' + u
        redirect '/login'
    end
end
#
get '/login' do
    erb :backend
end
#
get '/protected' do
    if session[:user_id]
        @uName = User.first(session[:user_id]).name
        erb :protected
    else
        redirect '/login'
    end
end
#
post '/login' do
    u = User.first(name: params[:name])
    if u
        if u.password == params[:password]
            session[:user_id] = u.id
            flash[:msg] = 'Hallo ' + u.name
            redirect '/protected'
        else
            flash[:errorMessage] = 'Wröng passw0rd'
            redirect '/login'
        end
    else
        flash[:errorMessage] = 'U hav n0 ak0unt'
        redirect '/login'
    end
end
#
DataMapper.finalize
DataMapper.auto_upgrade!