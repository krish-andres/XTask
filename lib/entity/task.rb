module XTask
  class Task
    attr_reader :name, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :id, :schedule
    attr_accessor :description, :start_time, :end_time, :type
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @monday = params[:monday] 
      @tuesday = params[:tuesday] 
      @wednesday = params[:wednesday] 
      @thurday = params[:thursday] 
      @friday = params[:friday] 
      @saturday = params[:saturday] 
      @sunday = params[:sunday] 
      @description = params[:description]
      @start_time = params[:start_time]
      @end_time = params[:end_time]
      @type = params[:type]
      @schedule = params[:schedule]
    end  
  end
end  
