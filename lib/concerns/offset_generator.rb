require 'scanf'
module OffsetGenerator
  def generate_offset(date, number=4)
    (date.to_i ** 2).to_s.split(//).map(&:to_i).last(number)
  end
end
