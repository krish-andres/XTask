require_relative '../spec_helper.rb'

describe XTask::User do
  it "initializes a user" do
    user = XTask::User.new({username: "firstuser", password: "secret"})
    expect(user).to be_a(XTask::User)
    expect(user.username).to eq("firstuser")
  end
end
