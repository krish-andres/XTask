module XTask
  class Task
    attr_reader :name, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :id
    attr_accessor :description, :start_time, :end_time, :type
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @monday = params[:monday] || false
      @tuesday = params[:tuesday] || false
      @wednesday = params[:wednesday] || false
      @thurday = params[:thursday] || false
      @friday = params[:friday] || false
      @saturday = params[:saturday] || false
      @sunday = params[:sunday] || false
      @description = params[:description]
      @start_time = params[:start_time]
      @end_time = params[:end_time]
      @type = params[:type]
    end  
  end
end  
