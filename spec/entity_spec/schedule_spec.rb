require_relative '../spec_helper.rb'

describe XTask::Schedule do
  it "initializes a schedule" do
    user = XTask::User.new({username: "Bob", password: "foobar"})
    schedule = XTask::Schedule.new({name: "Schedule 1", user: user})
    expect(schedule).to be_a(XTask::Schedule)
    expect(schedule.name).to eq("Schedule 1")
    expect(schedule.user.username).to eq("Bob")
  end
end
