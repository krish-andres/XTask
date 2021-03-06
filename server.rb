require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry-byebug'
require 'bcrypt'

enable :sessions

# module XTask

# end

require_relative 'xtask.rb'

set :bind, '0.0.0.0'

helpers do

  def signed_in?
    if session[:username].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:username]
  end
end

get '/' do
  redirect to('/dashboard') if signed_in?

  erb :index
end

get '/dashboard' do
  redirect to('/') unless signed_in?

  @user = XTask::UserRepo.new.find_by(username: username).first
  @schedules = XTask::ScheduleRepo.new.find_by(user: @user)
  erb :dashboard

end

post '/schedules' do
  puts params
  @name = params[:scheduleName]

  @user = XTask::UserRepo.new.find(params[:userName])

  
  @schedule = XTask::ScheduleRepo.new.create({name: @name, user: @user})
  redirect to("/schedules/#{@schedule.id}")
end


get '/schedules/:id' do
  redirect to('/') unless signed_in?

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
  @type = params[:taskType]
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
  redirect to("schedules/#{@schedule.id}")
end

post '/signup' do
  puts params
  @username = params[:username]
  @password_salt = BCrypt::Engine.generate_salt
  @password_hash = BCrypt::Engine.hash_secret(params[:password], @password_salt)

  XTask::UserRepo.new.create({username: @username, password: @password_hash, password_salt: @password_salt})

  session[:username] = params[:username]
  redirect to('/dashboard')
end

post '/signin' do
  @username = params[:username]
  @user = XTask::UserRepo.new.find_by(username: @username).first
  if @user && @user.password == BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
    session[:username] = params[:username]
    redirect to('/dashboard')
  else 
    redirect to('/signup')
  end

end

get '/signout' do
  session[:username] = nil
  redirect to('/')
end

get '/schedules/:schedule_id/tasks/:id/edit' do
  @schedule_id = params[:schedule_id]
  @task = XTask::TaskRepo.new.find(params[:id])

  erb :edit_task


end

put '/schedules/:schedule_id/tasks/:id' do
  puts params
  @name = params[:taskName]
  @description = params[:taskDesc]
  @type = params[:taskType]
  @start_time = params[:taskStart]
  @end_time = params[:taskEnd]
  @monday = params[:monday] 
  @tuesday = params[:tuesday]
  @wednesday = params[:wednesday]
  @thursday = params[:thursday]
  @friday = params[:friday]
  @saturday = params[:saturday]
  @sunday = params[:sunday]
  @schedule = XTask::ScheduleRepo.new.find(params[:schedule_id])
  XTask::TaskRepo.new.update({id: params[:id], name: @name, description: @description, type: @type, start_time: @start_time, end_time: @end_time, monday: @monday, tuesday: @tuesday, wednesday: @wednesday, thursday: @thursday, friday: @friday, saturday: @saturday, sunday: @sunday, schedule: @schedule})
  redirect to("/schedules/#{@schedule.id}")
end

delete '/schedules/:id' do
  XTask::ScheduleRepo.new.delete(params[:id])
  redirect to('/dashboard')
end

delete '/schedules/:schedule_id/tasks/:id' do
  @schedule = XTask::ScheduleRepo.new.find(params[:schedule_id])
  @task = XTask::TaskRepo.new.find(params[:id])
  XTask::TaskRepo.new.delete(id: params[:id], schedule: @schedule)

  redirect to("/schedules/#{@schedule.id}")

end






