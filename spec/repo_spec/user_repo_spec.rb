require_relative '../spec_helper.rb'
require 'bcrypt'

describe XTask::UserRepo do
  let(:users) { XTask::UserRepo.new }
  let(:password_salt) { BCrypt::Engine.generate_salt }

  before(:each) do
    users.drop_table
    users.create_table
  end

  describe "create and find" do
    
    it "adds a user to the database" do
      user = users.create({username: "example", password: "secret", password_salt: password_salt})
      expect(user).to be_a(XTask::User)
      expect(user.username).to eq("example")
    end

    it "finds a user by id" do
      user = users.create({username: "example", password: "secret"})
      found_user = users.find(user.id)
      expect(found_user).to be_a(XTask::User)
      expect(found_user.username).to eq("example")
    end
  end

  describe "find_all and find_by" do
    before(:each) do
      users.create({username: "example", password: "secret"})
      users.create({username: "second", password: "abracadabra"})
      users.create({username: "third", password: "foobar"})
    end

    it "finds all users in the database" do
      all_users = users.find_all
      expect(all_users.length).to eq(3)
      expect(all_users.first).to be_a(XTask::User)
    end

    it "finds a user in the database by username" do
      user = users.find_by({username: "third"})
      expect(user).to be_a(XTask::User)
      expect(user.username).to eq("third")
    end    
  end
end
