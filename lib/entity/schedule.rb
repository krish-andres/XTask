module XTask
  class Schedule
    attr_reader :id, :name, :user

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @user = params[:user]
    end
  end
end
