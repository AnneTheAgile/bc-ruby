# C:\amsrc\rmtry\lib\db.rb
module Db
  class Db
    attr_reader :items #not r/w  attr_accessor
    def initialize()
      @items = []
    end

    def clear()
      @items = []
    end

    def count()
      @items.size
    end

    def report
      @items.to_s
    end

  end
end