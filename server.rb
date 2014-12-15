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

post '/schedules' do
  puts params
  @name = params[:scheduleName]
  @username = params[:userName]
  binding.pry
  @schedule = XTask::ScheduleRepo.new.create({name: @name, username: @username})
  redirect to("/schedules/#{@schedule.id}")
end

get '/schedules/:id' do
  @schedule = XTask::ScheduleRepo.new.find(params[:id])
  @tasks = XTask::TaskRepo.new.find_all(schedule: @schedule)

  erb :schedule
end