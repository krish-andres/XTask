module XTask
  class User
  attr_reader :username, :id, :password_salt
  attr_accessor :password

    def initialize(params)
      @id = params[:id]
      @username = params[:username]
      @password = params[:password]
      @password_salt = params[:password_salt]
    end
  end
end
