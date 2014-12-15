require_relative '../spec_helper.rb'

describe XTask::Schedule do
  it "initializes a schedule" do
    schedule = XTask::Schedule.new({name: "Schedule 1", username: "Bob"})
    expect(schedule).to be_a(XTask::Schedule)
    expect(schedule.name).to eq("Schedule 1")
    expect(schedule.username).to eq("Bob")
  end
end
