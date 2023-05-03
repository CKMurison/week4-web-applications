require 'sinatra/base'

class Application < Sinatra::Base
  # GET /
  # Root path (homepage, index page)
  get '/' do
    
    return 'Hello!'
  end

  get '/hello' do
    return erb(:index)
  end

  get '/names' do
    return "Julia, Mary, Karim"
  end

  post '/sort-names' do
    names = params[:names]
    split_names = names.split(",")
    sorted_names = split_names.sort!
    return sorted_names.join(",")
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