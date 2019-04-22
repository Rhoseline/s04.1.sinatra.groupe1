require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    erb :show, locals: {
      id: params["id"],
      gossip: Gossip.find(params["id"].to_i)
    }
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    puts "gossip enregistré"
    redirect '/'
  end

  # run! if app_file == $0
end
