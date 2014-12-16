module XTask
  class UserRepo < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id SERIAL PRIMARY KEY,
          username TEXT, 
          password TEXT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS users CASCADE;
      SQL
      @db.exec(command)
    end

    def build_user(params)
      id = params['id']
      username = params['username']
      password = params['password']
      XTask::User.new({
        id: id, 
        username: username, 
        password: password
      })
    end

    def create(params)
      username = params[:username]
      password = params[:password]
      command = <<-SQL
        INSERT INTO users(username, password)
        VALUES ($1,$2)
        RETURNING *;
      SQL
      result = @db.exec(command, [username, password])
      build_user(result.first)
    end

    def find(id)
      command = <<-SQL
        SELECT * FROM users WHERE id=$1;
      SQL
      result = @db.exec(command, [id])
      build_user(result.first)
    end

    def find_all
      command = <<-SQL
        SELECT * FROM users;
      SQL
      results = @db.exec(command)
      results.map { |result| build_user(result) }
    end

    def find_by(params)
      username = params[:username]
      command = <<-SQL
        SELECT * FROM users WHERE username=$1;
      SQL
      results = @db.exec(command, [username])
      results.map { |result| build_user(result) }
    end

  end
end
