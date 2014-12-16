module XTask
  class User
  attr_reader :username, :id
  attr_accessor :password

    def initialize(params)
      @id = params[:id]
      @username = params[:username]
      @password = params[:password]
    end
  end
end
