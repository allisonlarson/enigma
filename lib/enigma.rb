require_relative 'cipher'

class Enigma
  def initialize(message)
    @message = message
  end

  def encrypt(offset)
    generate_ciphers(offset)

    transform_line(@message)
  end

  def decrypt(offset)
    offset.reverse!
    generate_ciphers(offset)

    transform_line(@message)
  end

  def transform_line(line)
    line.downcase.split(//).each_slice(4).map do |slice|
      slice[0] = @cipher_a[slice[0]]
      slice[1] = @cipher_b[slice[1]]
      slice[2] = @cipher_c[slice[2]]
      slice[3] = @cipher_d[slice[3]]
      slice
    end.compact.join
  end

  def generate_ciphers(offset)
    @cipher_a = Cipher.new.rotate!(offset.a_rotation)
    @cipher_b = Cipher.new.rotate!(offset.b_rotation)
    @cipher_c = Cipher.new.rotate!(offset.c_rotation)
    @cipher_d = Cipher.new.rotate!(offset.d_rotation)
  end
end

