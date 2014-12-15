require_relative '../spec_helper.rb'

describe XTask::TaskRepo do
  let(:tasks) { XTask::TaskRepo.new }
  let(:schedules) { XTask::ScheduleRepo.new }
  let(:one) { schedules.create({name: "Schedule 1", username: "Bob"})}
  let(:two) { schedules.create({name: "Schedule 2", username: "Joe"})}
  before(:each) do
    schedules.drop_table
    tasks.drop_table
    schedules.create_table
    tasks.create_table
  end

  describe "create and find by" do
    it "adds a task to the list" do
      task = tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false, schedule: one}) 
      expect(task).to be_a(XTask::Task)
      expect(task.monday).to eq('t')
      expect(task.tuesday).to eq('f')
      expect(task.name).to eq("Task 1")
      expect(task.start_time).to eq("18:00:00")
      expect(task.end_time).to eq("20:00:00")
      expect(task.schedule.name).to eq("Schedule 1")
    end

    it "retrieves an existing task" do
      tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false, schedule: two}) 
      task = tasks.find_by({name: "Task 1"}).first
      expect(task).to be_a(XTask::Task)
      expect(task.description).to eq("First task")
      expect(task.schedule.name).to eq("Schedule 2")
    end

    # it "retrieves all tasks of a given type AND/OR day" do

    # end
  end

  describe "find and find all" do
    it "finds a task by id" do
      task = tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false, schedule: one}) 
      found_task = tasks.find(task.id)
      expect(found_task).to be_a(XTask::Task)
      expect(found_task.name).to eq(task.name)
      expect(found_task.start_time).to eq(task.start_time)
    end

    it "finds all tasks from a given schedule" do
      tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false, schedule: one}) 
      tasks.create({name: "Task 2", description: "Second task", type: "School", start_time: "8:00am", end_time: "5:00pm", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false, schedule: two}) 
      tasks.create({name: "Task 3", description: "Third task", type: "Personal", start_time: "8:00pm", end_time: "9:00pm", monday: false, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: true, sunday: false, schedule: one}) 
      one_tasks = tasks.find_all(schedule: one)
      expect(one_tasks.length).to eq(2)
      expect(one_tasks.first).to be_a(XTask::Task)
    end    
  end

  # describe "update" do
  #   it "changes the specified attributes" do

  #   end
  # end
end






