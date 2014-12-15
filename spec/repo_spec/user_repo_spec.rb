require_relative '../spec_helper.rb'

describe XTask::UserRepo do
  let(:users) { XTask::UserRepo.new }
  before(:each) do
    users.drop_table
    users.create_table
  end

  describe "create and find" do
    
    it "adds a user to the database" do
      user = users.create({username: "example", email: "user@example.com", password: "secret"})
      expect(user).to be_a(XTask::User)
      expect(user.username).to eq("example")
      expect(user.email).to eq("user@example.com")
    end

    it "finds a user by id" do
      user = users.create({username: "example", email: "user@example.com", password: "secret"})
      found_user = users.find(user.id)
      expect(found_user).to be_a(XTask::User)
      expect(found_user.username).to eq("example")
      expect(found_user.email).to eq("user@example.com")
    end
  end

  describe "find all" do
    it "finds all users in the database" do
      users.create({username: "example", email: "user@example.com", password: "secret"})
      users.create({username: "second", email: "second@example.com", password: "abracadabra"})
      users.create({username: "third", email: "third@example.com", password: "foobar"})
      all_users = users.find_all
      expect(all_users.length).to eq(3)
      expect(all_users.first).to be_a(XTask::User)
    end
  end
end
