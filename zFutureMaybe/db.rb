# C:\amsrc\rmtry\lib\db.rb
module Db
  class Db
    attr_reader :items #not r/w  attr_accessor
    def initialize()
      @products = []
    end

    def clear()
      @products = []
    end

    def count()
      @products.size
    end

    def report
      @products.to_s
    end

  end
end