require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    check = @name = params[:name]
    if check =~ /^[a-z ,.'-]+$/
      @name = check
    end

    return erb(:hello)
  end
end