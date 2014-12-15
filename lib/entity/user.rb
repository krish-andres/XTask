module XTask
  class User
  attr_reader :username, :email, :id
  attr_accessor :password

    def initialize(params)
      @id = params[:id]
      @username = params[:username]
      @email = params[:email]
      @password = params[:password]
    end
  end
end
