require_relative '../spec_helper.rb'

describe XTask::ScheduleRepo do
  let(:schedules) { XTask::ScheduleRepo.new }
  let(:users) { XTask::UserRepo.new }
  let(:user1) { users.create({username: "Bob", password: "secret"}) }
  let(:user2) { users.create({username: "Joe", password: "foobar"}) }

  before(:each) do
    users.drop_table
    schedules.drop_table
    users.create_table
    schedules.create_table
  end

  describe "create and find by" do
    it "adds a schedule to the list" do
      schedule = schedules.create({name: "Schedule 1", user: user1})
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.name).to eq("Schedule 1")
      expect(schedule.user.username).to eq("Bob")
    end

    it "finds a schedule by name" do
      schedules.create({name: "Schedule 1", user: user1})
      schedule = schedules.find_by({name: "Schedule 1"}).first
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.user.username).to eq("Bob")
    end

    it "finds a schedule by user" do
      schedules.create({name: "Schedule 1", user: user1})
      schedule = schedules.find_by({user: user1}).first
      expect(schedule).to be_a(XTask::Schedule)
      expect(schedule.name).to eq("Schedule 1")
    end

    it "finds all schedules of a given user" do
      schedules.create({name: "Schedule 1", user: user1})
      schedules.create({name: "Schedule 2", user: user1})
      schedules.create({name: "Schedule 3", user: user2})
      user1_schedules = schedules.find_by({user: user1})
      expect(user1_schedules.length).to eq(2)
      expect(user1_schedules.first).to be_a(XTask::Schedule)
    end
  end

  describe "find and find all" do
    it "finds a schedule by id" do
      schedule = schedules.create({name: "Schedule 1", user: user1})
      found_schedule = schedules.find(schedule.id)
      expect(found_schedule).to be_a(XTask::Schedule)
      expect(found_schedule.name).to eq(schedule.name)
      expect(found_schedule.user.username).to eq(schedule.user.username)
    end

    it "finds all schedules from the database" do
      schedules.create({name: "Schedule 1", user: user1})
      schedules.create({name: "Schedule 2", user: user2})
      schedules.create({name: "Schedule 3", user: user2})
      all_schedules = schedules.find_all
      expect(all_schedules.length).to eq(3)
      expect(all_schedules.first).to be_a(XTask::Schedule)
    end
  end
end
