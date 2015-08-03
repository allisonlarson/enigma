require_relative 'test_helper'

class EnigmaTest < Minitest::Test
  def test_it_encrypts
    enigma = Enigma.new("hello My Name is allie ..end..")
    offset = Offset.new("45632", "031215")

    assert_equal "uyak2rbxk82lrr rkuakvyy lyccls", enigma.encrypt(offset)
  end

  def test_it_encrypts_with_capitalization
    enigma = Enigma.new("MESSAGE")
    offset = Offset.new("12345", "010101")

    assert_equal "y4o1m6a", enigma.encrypt(offset)
  end

  def test_it_encrypts_and_ignores_special_chars
    enigma = Enigma.new("ME!!AGE")
    offset = Offset.new("12345", "010101")

    assert_equal "y4m6a", enigma.encrypt(offset)
  end

  def test_it_decrypts
    enigma = Enigma.new("uyak2rbxk82lrr rkuakvy")
    offset = Offset.new("45632", "031215")

    assert_equal "hello my name is allie", enigma.decrypt(offset)
  end
end
