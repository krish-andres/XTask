require_relative 'xtask.rb'

task :prep do
  task_repo = XTask::TaskRepo.new
  task_repo.drop_table
  task_repo.create_table
  task1 = task_repo.create({name: "MakerSquare Class", description: "Learning to be a kickass programmer!", type: "School", start_time: "9:00am", end_time: "6:00pm", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false}) 
  task2 = task_repo.create({name: "Gym", description: "Picking heavy things up and putting them down", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: false, sunday: false}) 
  task3 = task_repo.create({name: "Cleaning", description: "Cleaning my living space", type: "Personal", start_time: "9:00pm", end_time: "10:00pm", monday: false, tuesday: false, wednesday: true, thursday: false, friday: false, saturday: false, sunday: true}) 
  task4 = task_repo.create({name: "Writing", description: "Weekly Blogging", type: "Personal", start_time: "7:00pm", end_time: "8:00pm", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, saturday: false, sunday: false}) 

  `bundle exec ruby server.rb`
end
