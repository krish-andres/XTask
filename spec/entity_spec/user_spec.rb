require_relative '../spec_helper.rb'
require 'bcrypt'

describe XTask::User do
  it "initializes a user" do
    password_salt = BCrypt::Engine.generate_salt
    user = XTask::User.new({username: "firstuser", password: "secret", password_salt: password_salt})
    expect(user).to be_a(XTask::User)
    expect(user.username).to eq("firstuser")
  end
end
