#include needed gems
require 'data_mapper'
require 'dm-sqlite-adapter'
#
#Set path to DB
DataMapper.setup(:default, 'sqlite:///Users/r00t/Documents/database.db')
#########################
class Post
    include DataMapper::Resource
    #define Properties
    property :id,           Serial
    property :title,        String
    property :body,         Text
    property :created_at,   DateTime
#End Class
end
#
#update Model-Relations
DataMapper.finalize
#
#update DB
DataMapper.auto_upgrade!