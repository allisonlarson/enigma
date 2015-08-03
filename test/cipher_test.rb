require_relative 'test_helper'

class CipherTest < Minitest::Test

  def test_it_has_a_cipher
    cipher = Cipher.new

    assert_equal 38, cipher.cipher.length
  end

  def test_cipher_can_rotate_once
    cipher = Cipher.new

    cipher.rotate!
    assert_equal "b", cipher.cipher["a"]
  end

  def test_cipher_can_rotate_multiple_times
    cipher = Cipher.new

    cipher.rotate!(5)
    assert_equal "f", cipher.cipher["a"]
  end

  def test_cipher_can_rotate_negative_times
    cipher = Cipher.new

    cipher.rotate!(-25)
    assert_equal "e", cipher.cipher["4"]
  end
end
