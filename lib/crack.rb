require_relative 'runner'

options = {
  message_file: ARGV[0],
  new_file: ARGV[1],
  date: ARGV[3]
}

puts Runner.new(options).crack
