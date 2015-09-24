require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
adapter: "sqlite3",
database: File.dirname(__FILE__) + "/definitions.db"
)

class Definition < ActiveRecord::Base
  validates :word, presence: true
  validates :meaning, presence: true
end


require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'

set :port, 3027

Tilt.register Tilt::ERBTemplate, 'html.erb'

get "/" do
  erb :home
end

get "/add" do
  erb :add
end

post "/save" do
  add_word = Definition.create(word: params["word"], meaning: params["meaning"]).valid?
  if add_word == true
    redirect '/'
  else
    redirect '/error'
  end
end

get '/error' do
  erb :error
end

get "/search" do

  definition = Definition.find_by(word: params[:search])
  @definition = "#{definition.word} = #{definition.meaning}"
  erb :search
end
