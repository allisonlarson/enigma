require_relative 'concerns/char_map'
require_relative 'concerns/offset_generator'

class EnigmaCracker
  include CharMap
  include OffsetGenerator

  def initialize(message, date, options = {})
    @message = message
    @known_message = options[:known] || "..end.."
    @char_map = char_map
    @date = date
    @number_of_ciphers = options[:number_of_ciphers] || 4
  end

  def crack_key
    # get the index positions of the known keywords letters, and corresponding encrypted keywords letters
    known_indexes = get_indexes(@known_message)
    encrypted_indexes = get_indexes(@message[-@known_message.length, @known_message.length])

    # subtract the paired indexes to get the number of rotations between the encrypted and unencrypted letters
    rotations = get_rotations(known_indexes, encrypted_indexes)

    # reverse the rotations so that the encrypted letter points to its unencrypted letter
    inverted_rotations = reverse_rotations(rotations)

    # figure out what position each cipher is using
    ordered_rotations = inverted_rotations.rotate!(-@message.length % @number_of_ciphers)

    # generate the key
    generate_key!(ordered_rotations)
  end

  def get_indexes(message)
    message.each_char.map do |char|
      index_map[char]
    end
  end

  def get_rotations(known_indexes, encrypted_indexes)
    known_indexes.zip(encrypted_indexes).map do |indexes|
      number = indexes[0] - indexes[1]
      # if it takes negative rotations, get the positive counter rotations
      number = @char_map.length + number if number < 0
      number
    end.flatten.last(@number_of_ciphers)
  end

  def reverse_rotations(rotations)
    rotations.map{ |number| @char_map.length - number }
  end

  def generate_key!(rotations)
    # generate the possible key values
    keys = generate_options(rotations)

    # get all combinations of keys from its options, and then only return a key if its
    # each individual key matches its neighboring keys (ie 12, 23, 34, 45 to return 12345)
    keys.inject(&:product).map(&:flatten).reduce([]) do |a, array|
      key = array.join.gsub(/((.)\2)/, "\\2")

      a.push(key) if key.length == 5
      a
    end.first
  end

  private

  def generate_options(rotations)
    # get the known offset from the date
    offset = generate_offset(@date)

    # get each rotations possible key based on how many rotations of the char_map it could do
    key = rotations.map.with_index do |num, i|
      [format_number(num - offset[i]),
       format_number(@char_map.length + num - offset[i])]
    end
    key
  end

  def format_number(num)
    str_num = num.to_s
    str_num.length == 1 ? str_num.prepend("0") : str_num
  end

  def index_map
    @index_hash ||= @char_map.map.with_index { |char, i| [char, i] }.to_h
  end
end
