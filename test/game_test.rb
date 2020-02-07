require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'

class Gametest < Minitest::Test
  def test_user_input_can_be_anything
    user_input = sanitize_input("a1a2a3")

    assert_equal ""
  end
end
