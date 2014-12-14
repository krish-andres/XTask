require_relative '../spec_helper.rb'

describe XTask::TaskRepo do
  let(:tasks) { XTask::TaskRepo.new }
  before(:each) do
    tasks.drop_table
    tasks.create_table
  end

  describe "create and find by" do
    it "adds a task to the list" do
      task = tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false}) 
      expect(task).to be_a(XTask::Task)
      expect(task.monday).to eq('t')
      expect(task.tuesday).to eq('f')
      expect(task.name).to eq("Task 1")
      expect(task.start_time).to eq("18:00:00")
      expect(task.end_time).to eq("20:00:00")
    end

    it "retrieves an existing task" do
      tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false}) 
      task = tasks.find_by({name: "Task 1"}).first
      expect(task).to be_a(XTask::Task)
      expect(task.description).to eq("First task")
    end

    it "retrieves all tasks of a given type" do
      tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false}) 
      school_task = tasks.create({name: "Task 2", description: "Second task", type: "School", start_time: "8:00am", end_time: "5:00pm", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false}) 
      tasks.create({name: "Task 3", description: "Third task", type: "Exercise", start_time: "8:00pm", end_time: "9:00pm", monday: false, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: true, sunday: false}) 
      exercise_tasks = tasks.find_by({type: "Exercise"})
      expect(exercise_tasks.length).to eq(2)
      expect(exercise_tasks).not_to include(school_task)
    end

    # it "retrieves all tasks of a given day" do

    # end
  end

  describe "find and find all" do
    it "finds a task by id" do
      task = tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false}) 
      found_task = tasks.find(task.id)
      expect(found_task).to be_a(XTask::Task)
      expect(found_task.name).to eq(task.name)
      expect(found_task.start_time).to eq(task.start_time)
    end

    it "finds all tasks from the database" do
      tasks.create({name: "Task 1", description: "First task", type: "Exercise", start_time: "6:00pm", end_time: "8:00pm", monday: true, tuesday: false, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false}) 
      tasks.create({name: "Task 2", description: "Second task", type: "School", start_time: "8:00am", end_time: "5:00pm", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false}) 
      tasks.create({name: "Task 3", description: "Third task", type: "Personal", start_time: "8:00pm", end_time: "9:00pm", monday: false, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: true, sunday: false}) 
      all_tasks = tasks.find_all
      expect(all_tasks.length).to eq(3)
      expect(all_tasks.first).to be_a(XTask::Task)
    end    
  end

  # describe "update" do
  #   it "changes the specified attributes" do

  #   end
  # end
end






