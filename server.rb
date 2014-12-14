require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry-byebug'

module XTask
  def self.db
    @db ||= PG.connect(dbname: 'songify-db')
  end
end

require_relative 'xtask.rb'

set :bind, '0.0.0.0'

get '/' do
  
  erb :index
end