module XTask
  class ScheduleRepo < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS schedules(
          id SERIAL PRIMARY KEY, 
          name TEXT, 
          user_id INTEGER REFERENCES users (id)
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
      user_id = params['user_id']
      user = XTask::UserRepo.new.find(user_id)
      XTask::Schedule.new({
        id: id, 
        name: name, 
        user: user
      })
    end

    def create(params)
      name = params[:name]
      user_id = params[:user].id
      command = <<-SQL
        INSERT INTO schedules(name, user_id)
        VALUES ($1,$2)
        RETURNING *; 
      SQL
      result = @db.exec(command, [name, user_id])
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
      user = params[:user]
      user_id = user.id if user
      command = <<-SQL
        SELECT * FROM schedules
      SQL
      
      if name
        spec = <<-SQL
          WHERE name=$1;
        SQL
        results = @db.exec(command + spec, [name])
      elsif user
        spec = <<-SQL
          WHERE user_id=$1;
        SQL
        results = @db.exec(command + spec, [user_id])
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
