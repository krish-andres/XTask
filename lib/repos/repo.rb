require 'pg'

module XTask
  class Repo
    def initialize
      @db = XTask.db
    end
  end
end