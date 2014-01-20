#!/usr/bin/env ruby
#why won't run with rubymine but ok in actual irb???
require './lib/terminal'
require './lib/store'
(Terminal::Terminal.new(Store::Store.new)).runInteractive
