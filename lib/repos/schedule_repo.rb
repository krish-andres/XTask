module XTask
  class ScheduleRepo < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS schedules(
          id SERIAL PRIMARY KEY, 
          name TEXT, 
          username TEXT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS schedules CASCADE;
      SQL
      @db.exec(command)
    end

    def build_schedule(params)
      id = params['id']
      name = params['name']
      username = params['username']
      XTask::Schedule.new({
        id: id, 
        name: name, 
        username: username
      })
    end

    def create(params)
      name = params[:name]
      username = params[:username]
      command = <<-SQL
        INSERT INTO schedules(name, username)
        VALUES ($1,$2)
        RETURNING *; 
      SQL
      result = @db.exec(command, [name, username])
      build_schedule(result.first)
    end

    def find(id)
      command = <<-SQL
        SELECT * FROM schedules WHERE id=$1;
      SQL
      result = @db.exec(command, [id])
      build_schedule(result.first)
    end

    def find_by(params)
      name = params[:name]
      username = params[:username]
      command = <<-SQL
        SELECT * FROM schedules
      SQL
      
      if name
        spec = <<-SQL
          WHERE name=$1;
        SQL
        results = @db.exec(command + spec, [name])
      elsif username
        spec = <<-SQL
          WHERE username=$1;
        SQL
        results = @db.exec(command + spec, [username])
      end
      results.map { |result| build_schedule(result) }
    end

    def find_all
      command = <<-SQL
        SELECT * FROM schedules;
      SQL
      results = @db.exec(command)
      results.map { |result| build_schedule(result) }
    end



  end
end
