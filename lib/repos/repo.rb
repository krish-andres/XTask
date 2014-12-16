require 'pg'

module XTask

  def self.db
    @db ||= PG.connect(dbname: 'xtask-db')
  end
  
  class Repo
    def initialize
      @db = XTask.db
      # @db = PG.connect(dbname: 'xtask-db')
    end
  end
end