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
  
  @schedule = XTask::ScheduleRepo.new.create({name: @name, username: @username})
  redirect to("/schedules/#{@schedule.id}")
end

get '/schedules/:id' do
  @schedule = XTask::ScheduleRepo.new.find(params[:id])
  @tasks = XTask::TaskRepo.new.find_all(schedule: @schedule)
  @monday = XTask::TaskRepo.new.find_by(schedule: @schedule, monday: true)
  @tuesday = XTask::TaskRepo.new.find_by(schedule: @schedule, tuesday: true)
  @wednesday = XTask::TaskRepo.new.find_by(schedule: @schedule, wednesday: true)
  @thursday = XTask::TaskRepo.new.find_by(schedule: @schedule, thursday: true)
  @friday = XTask::TaskRepo.new.find_by(schedule: @schedule, friday: true)
  @saturday = XTask::TaskRepo.new.find_by(schedule: @schedule, saturday: true)
  @sunday = XTask::TaskRepo.new.find_by(schedule: @schedule, sunday: true)

  erb :schedule
end

post '/schedules/:id/tasks' do
  puts params
  @name = params[:taskName]
  @description = params[:taskDesc]
  @type = params[:type]
  @start_time = params[:taskStart]
  @end_time = params[:taskEnd]
  @monday = params[:monday] 
  @tuesday = params[:tuesday]
  @wednesday = params[:wednesday]
  @thursday = params[:thursday]
  @friday = params[:friday]
  @saturday = params[:saturday]
  @sunday = params[:sunday]
  @schedule = XTask::ScheduleRepo.new.find(params[:scheduleId])
  XTask::TaskRepo.new.create({name: @name, description: @description, type: @type, start_time: @start_time, end_time: @end_time, monday: @monday, tuesday: @tuesday, wednesday: @wednesday, thursday: @thursday, friday: @friday, saturday: @saturday, sunday: @sunday, schedule: @schedule})
  redirect_to ("schedules/#{@schedule.id}")
end



