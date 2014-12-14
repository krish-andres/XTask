module XTask
  class TaskRepo < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS tasks(
          id SERIAL PRIMARY KEY,
          name TEXT,
          description TEXT,
          type TEXT,
          start_time TIME, 
          end_time TIME, 
          monday BOOLEAN, 
          tuesday BOOLEAN, 
          wednesday BOOLEAN, 
          thursday BOOLEAN, 
          friday BOOLEAN, 
          saturday BOOLEAN, 
          sunday BOOLEAN 
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS tasks CASCADE;
      SQL
      @db.exec(command)
    end

    def build_task(params)
      id = params['id']
      name = params['name']
      description = params['description']
      type = params['type']
      start_time = params['start_time']
      end_time = params['end_time']
      monday = params['monday']
      tuesday = params['tuesday']
      wednesday = params['wednesday']
      thursday = params['thursday']
      friday = params['friday']
      saturday = params['saturday']
      sunday = params['sunday']

      XTask::Task.new({
        id: id, 
        name: name, 
        description: description, 
        type: type, 
        start_time: start_time, 
        end_time: end_time, 
        monday: monday, 
        tuesday: tuesday, 
        wednesday: wednesday, 
        thursday: thursday, 
        friday: friday, 
        saturday: saturday, 
        sunday: sunday
      })
    end

    def create(params)
      name = params[:name]
      description = params[:description]
      type = params[:type]
      start_time = params[:start_time]
      end_time = params[:end_time]
      monday = params[:monday]
      tuesday = params[:tuesday]
      wednesday = params[:wednesday]
      thursday = params[:thursday]
      friday = params[:friday]
      saturday = params[:saturday]
      sunday = params[:sunday]  
      command = <<-SQL
        INSERT INTO tasks(name, description, type, start_time, end_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
        VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, description, type, start_time, end_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday])
      build_task(result.first)
    end

    def find_by(params)
      name = params[:name]
      type = params[:type]
      command = <<-SQL
        SELECT * FROM tasks
      SQL

      if name
        spec = <<-SQL
          WHERE name=$1;
        SQL
        results = @db.exec(command + spec, [name])
      elsif type
        spec = <<-SQL
          WHERE type=$1;
        SQL
        results = @db.exec(command + spec, [type])
      end
      results.map { |result| build_task(result) }
    end

    def find(id)
      command = <<-SQL
        SELECT * FROM tasks WHERE id=$1; 
      SQL
      result = @db.exec(command, [id])
      build_task(result.first)
    end

    def find_all
      command = <<-SQL
        SELECT * FROM tasks; 
      SQL
      results = @db.exec(command)
      results.map { |result| build_task(result) }
    end



  end
end
