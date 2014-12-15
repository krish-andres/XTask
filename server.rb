require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry-byebug'

# module XTask
#   def self.db
#     @db ||= PG.connect(dbname: 'xtask-db')
#   end
# end

require_relative 'xtask.rb'

set :bind, '0.0.0.0'

get '/' do
  @schedules = XTask::ScheduleRepo.new.find_all
  erb :index
end