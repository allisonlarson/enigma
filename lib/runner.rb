require 'date'
require_relative 'key'
require_relative 'offset'
require_relative 'enigma'
require_relative 'enigma_cracker'

class Runner
  def initialize(options)
    @message = options[:message] || read_file(options[:message_file])
    @new_filename = options[:new_file]
    @date = options[:date] || formatted_date
    @key = options[:key] || Key.generate!
    @enigma = Enigma.new(@message)
    @offset = Offset.new(@key, @date)
  end

  def encrypt
    encrypted_text = @enigma.encrypt(@offset)
    output(encrypted_text)
  end

  def decrypt
    decrypted_text = @enigma.decrypt(@offset)
    output(decrypted_text)
  end

  def crack
    @key = EnigmaCracker.new(@message, @date).crack_key
    @offset = Offset.new(@key, @date)

    decrypt
  end

  private

  def output(content)
    @new_filename.nil? ? output_content(content) : write_file(content)
  end

  def output_content(content)

    "Received #{@message} with key #{@key} on date #{@date} and got #{content}"
  end

  def read_file(file)
    File.open(file, "rb").read
  end

  def write_file(contents)
    File.open(@new_filename, "w") do |f|
      f << contents
    end
    "Created '#{@new_filename}' with the key #{@key} and the date #{@date}"
  end

  def formatted_date
    Date.today.strftime("%d%m%y")
  end
end

