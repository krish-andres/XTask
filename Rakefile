require_relative 'xtask.rb'

task :prep do
  user_repo = XTask::UserRepo.new
  schedule_repo = XTask::ScheduleRepo.new
  task_repo = XTask::TaskRepo.new
  user_repo.drop_table
  schedule_repo.drop_table
  task_repo.drop_table
  user_repo.create_table
  schedule_repo.create_table
  task_repo.create_table
  user1 = user_repo.create({username: "Bob", password: "foobar"})
  user2 = user_repo.create({username: "Joe", password: "secret"})
  schedule1 = schedule_repo.create({name: "Bob's Schedule", user: user1})
  schedule2 = schedule_repo.create({name: "Joe's Schedule", user: user2})
  task1 = task_repo.create({name: "MakerSquare Class", description: "Learning to be a kickass programmer!", type: "School", start_time: "9:00am", end_time: "6:00pm", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false, schedule: schedule1}) 
  task2 = task_repo.create({name: "Gym", description: "Picking heavy things up and putting them down", type: "Personal", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: false, sunday: false, schedule: schedule2}) 
  task3 = task_repo.create({name: "Cleaning", description: "Cleaning my living space", type: "Housekeeping", start_time: "9:00pm", end_time: "10:00pm", monday: false, tuesday: false, wednesday: true, thursday: false, friday: false, saturday: false, sunday: true, schedule: schedule2}) 
  task4 = task_repo.create({name: "Writing", description: "Weekly Blogging", type: "Personal", start_time: "7:00pm", end_time: "8:00pm", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, saturday: false, sunday: false, schedule: schedule2}) 

  `bundle exec ruby server.rb`
end
