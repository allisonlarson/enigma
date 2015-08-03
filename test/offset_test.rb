require_relative 'test_helper'

class OffsetTest < Minitest::Test

  def setup
    key = "12345"
    date = "010101"
    @offset = Offset.new(key, date)
  end

  def test_it_initializes_with_rotations
    assert_equal 12, @offset.a_rotation
    assert_equal 25, @offset.b_rotation
    assert_equal 34, @offset.c_rotation
    assert_equal 46, @offset.d_rotation
  end

  def test_it_reverses_rotations
    @offset.reverse!

    assert_equal -12, @offset.a_rotation
    assert_equal -25, @offset.b_rotation
    assert_equal -34, @offset.c_rotation
    assert_equal -46, @offset.d_rotation
  end
end
