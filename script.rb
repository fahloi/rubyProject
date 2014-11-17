#include needed gems
require 'data_mapper'
require 'dm-sqlite-adapter'
#
#Set path to DB
DataMapper.setup(:default, 'sqlite:///Users/r00t/Documents/fcms.db')
#########################
class Post
    include DataMapper::Resource
    #define Properties
    property :id,           Serial
    property :title,        String
    property :subtitle,     String
    property :content,      Text
    property :created_at,   DateTime
    property :created_by,   String
    
    has n, :comments
#End Class
end

class Comment
    include DataMapper::Resource
    #define Properties
    property :id,           Serial
    property :title,        String
    property :content,      Text
    property :created_at,   DateTime
    property :created_by,   String
    
    belongs_to :post
#End Class
end
    
#
#update Model-Relations
DataMapper.finalize
#
#update DB
DataMapper.auto_upgrade!