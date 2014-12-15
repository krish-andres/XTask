require_relative '../spec_helper.rb'

describe XTask::ScheduleRepo do
  let(:schedules) { XTask::ScheduleRepo.new }
  before(:each) do
    schedules.drop_table
    schedules.create_table
  end

  describe "create and find by" do
    it "adds a schedule to the list" do
      schedule = schedules.create({name: "Schedule 1", username: "Bob"})
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.name).to eq("Schedule 1")
      expect(schedule.username).to eq("Bob")
    end

    it "finds a schedule by name" do
      schedules.create({name: "Schedule 1", username: "Bob"})
      schedule = schedules.find_by({name: "Schedule 1"}).first
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.username).to eq("Bob")
    end

    it "finds a schedule by username" do
      schedules.create({name: "Schedule 1", username: "Bob"})
      schedule = schedules.find_by({username: "Bob"}).first
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.name).to eq("Schedule 1")
    end
  end

  describe "find and find all" do
    it "finds a schedule by id" do
      schedule = schedules.create({name: "Schedule 1", username: "Bob"})
      found_schedule = schedules.find(schedule.id)
      expect(found_schedule).to be_a(XTask::Schedule)
      expect(found_schedule.name).to eq(schedule.name)
      expect(found_schedule.username).to eq(schedule.username)
    end

    it "finds all schedules from the database" do
      schedules.create({name: "Schedule 1", username: "Bob"})
      schedules.create({name: "Schedule 2", username: "Joe"})
      schedules.create({name: "Schedule 3", username: "Jon"})
      all_schedules = schedules.find_all
      expect(all_schedules.length).to eq(3)
      expect(all_schedules.first).to be_a(XTask::Schedule)
    end
  end
end
