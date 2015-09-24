require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.dirname(__FILE__) + "/definitions.db"
  )

class Definition < ActiveRecord::Base
end


require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'

set :port, 3027

Tilt.register Tilt::ERBTemplate, 'html.erb'

def return_dict
  Definition.all.each do |value|
    @words = value.word
    @meanings = value.meaning
    puts "#{@words} = #{@meanings}"
  end
end

get "/" do

  # return "words = meanings" from definitions table

  erb :home
end

get "/add" do
  erb :add
end

post "/save" do
  Definition.create(word: params["word"], meaning: params["meaning"])

  redirect '/'
end

get "/search" do

  definition = Definition.find_by(word: params[:search])
  @definition = "#{definition.word} = #{definition.meaning}"
  erb :search
end
