require "simplecov"

SimpleCov.start do
  add_filter "lib/game.rb"
  add_filter "lib/output_module.rb"
end

require "minitest/autorun"
require "minitest/pride"
