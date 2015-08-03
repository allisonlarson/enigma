require_relative 'test_helper'
class EngimaCrackerTest < Minitest::Test

  def test_it_cracks_the_key
    cracker = EnigmaCracker.new("uyak2rbxk82lrr rkuakvyy lyccls", "031215")
    assert_equal "45632", cracker.crack_key
  end

  def test_it_cracks_another_key
    cracker = EnigmaCracker.new("kxavpx7", "010101")
    assert_equal "12345", cracker.crack_key
  end

  def test_it_cracks_a_key_with_duplicate_numbers
    cracker = EnigmaCracker.new("q31p39eu33", "020815")
    assert_equal "26650", cracker.crack_key
  end

  def test_it_cracks_a_key_with_zeros
    cracker = EnigmaCracker.new("5iflec,jqipoqc", "020815")
    assert_equal "14006", cracker.crack_key
  end
end
