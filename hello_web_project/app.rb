require 'sinatra/base'

class Application < Sinatra::Base
  # GET /
  # Root path (homepage, index page)
  get '/' do
    
    return 'Hello!'
  end

  get '/posts' do
    return 'a list of posts'
  end

  post '/posts' do
    return 'Post was created'
  end
end
# Incoming request: GET /todos/1

# Routes 

# GET /    -> execute some code

# GET /todos/1  -> execute a different piece of code  # only this code will be executed

# POST /todos   -> execute some different code



# Incoming request: GET /posts

# Routes 

# GET /    -> execute some code

# GET /todos/1  -> execute a different piece of code 

# POST /todos   -> execute some different code

# 404 error