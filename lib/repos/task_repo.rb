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
          sunday BOOLEAN, 
          schedule_id INTEGER REFERENCES schedules (id)
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
      schedule_id = params['schedule_id']
      schedule = XTask::ScheduleRepo.new.find(schedule_id)

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
        sunday: sunday, 
        schedule: schedule
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
      schedule_id = params[:schedule].id 
      command = <<-SQL
        INSERT INTO tasks(name, description, type, start_time, end_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday, schedule_id)
        VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12, $13)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, description, type, start_time, end_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday, schedule_id])
      build_task(result.first)
    end

    def find_by(params)
      schedule = params[:schedule]
      schedule_id = schedule.id
      name = params[:name]
      monday = params[:monday]
      tuesday = params[:tuesday]
      wednesday = params[:wednesday]
      thursday = params[:thursday]
      friday = params[:friday]
      saturday = params[:saturday]
      sunday = params[:sunday]
      command = <<-SQL
        SELECT * FROM tasks WHERE schedule_id=$1 AND
      SQL

      case 
      when name
        spec = <<-SQL
          name=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, name])
      when monday
        spec = <<-SQL
          monday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, monday])             
      when tuesday
        spec = <<-SQL
          tuesday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, tuesday])             
      when wednesday
        spec = <<-SQL
          wednesday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, wednesday])             
      when thursday
        spec = <<-SQL
          thursday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, thursday])             
      when friday
        spec = <<-SQL
          friday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, friday])             
      when saturday
        spec = <<-SQL
          saturday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, saturday])             
      when sunday
        spec = <<-SQL
          sunday=$2;
        SQL
        results = @db.exec(command + spec, [schedule_id, sunday])             
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

    def find_all(params)
      schedule = params[:schedule]
      schedule_id = schedule.id
      command = <<-SQL
        SELECT * FROM tasks WHERE schedule_id=$1; 
      SQL
      results = @db.exec(command, [schedule_id])
      results.map { |result| build_task(result) }
    end

  end
end
