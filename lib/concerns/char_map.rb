module CharMap
  def char_map
    chars = ("a".."z").to_a
    nums = (1..9).to_a.map(&:to_s)
    misc = [" ", ".", ","]

    chars += nums += misc
  end
end
