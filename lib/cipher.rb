require_relative 'concerns/char_map'

class Cipher
  include CharMap

  attr_reader :cipher

  def initialize
    @cipher ||= generate
  end

  # re-generates the cipher after the values have been rotated by the number
  # of times specified. ie Rotating once will give you cipher["a"] = "b"
  def rotate!(number = 1)
    rotated_map = char_map.rotate!(number)
    @cipher = char_map.zip(rotated_map).to_h
  end

  # creates a hash where keys of the char_map are the same as their values
  # serves as a 0-index for rotations. ie cipher["a"] = "a"
  def generate
    char_map.zip(char_map).to_h
  end
end
