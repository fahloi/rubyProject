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
get '/login' do
    erb :backend
end
#
get '/protected' do
    @uName = User.first(session[:user_id]).name
    erb :protected
end
#
post '/check' do
    u = User.first(name: params[:name])
    if u
        if u.password == params[:password]
            session[:user_id] = u.id
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