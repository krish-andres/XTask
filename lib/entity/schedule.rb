module XTask
  class Schedule
    attr_reader :id, :name, :username

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @username = params[:username]
    end
  end
end
