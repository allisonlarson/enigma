require_relative 'concerns/offset_generator'

class Offset
  include OffsetGenerator

  attr_reader :a_rotation, :b_rotation, :c_rotation, :d_rotation

  def initialize(key, date)
    offset = generate_offset(date)

    @a_rotation = key[0..1].to_i + offset[0]
    @b_rotation = key[1..2].to_i + offset[1]
    @c_rotation = key[2..3].to_i + offset[2]
    @d_rotation = key[3..4].to_i + offset[3]
  end

  def reverse!
    @a_rotation = -@a_rotation
    @b_rotation = -@b_rotation
    @c_rotation = -@c_rotation
    @d_rotation = -@d_rotation
  end
end
