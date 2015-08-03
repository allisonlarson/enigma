class Key
  def self.generate!
    5.times.map { Random.rand(9) }.join
  end
end
