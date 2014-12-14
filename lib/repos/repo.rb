require 'pg'

module XTask
  class Repo
    def initialize
      # @db = XTask.db
      @db = PG.connect(dbname: 'xtask-db')
    end
  end
end