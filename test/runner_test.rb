require_relative 'test_helper'

class RunnerTest < Minitest::Test

  def test_it_outputs_stuff_on_encrypt
    options = { message: "message", key: "12345" }
    todays_date = Date.today.strftime("%d%m%y")
    @runner = Runner.new(options)

    assert_includes @runner.encrypt, "Received #{options[:message]} with key #{options[:key]} on date #{todays_date}"
  end

  def test_it_outputs_stuff_on_decrypt
    options = { message: "message", key: "12345"}
    todays_date = Date.today.strftime("%d%m%y")
    @runner = Runner.new(options)

    assert_includes @runner.decrypt, "Received #{options[:message]} with key #{options[:key]} on date #{todays_date}"
  end

  def test_it_outputs_stuff_on_crack
    options = { message: "kxavpx7", date: "010101"}
    @runner = Runner.new(options)

    assert_includes @runner.crack, "Received #{options[:message]} with key 12345 on date #{options[:date]}"
  end
end
