require_relative 'test_helper'

class KeyTest < Minitest::Test

  def test_it_creates_a_random_number
    key1 = Key.generate!
    key2 = Key.generate!
    refute_same key1, key2
  end
end
