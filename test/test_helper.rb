gem 'test-unit' if RUBY_VERSION > '1.9'
require 'test/unit'
require 'rake'

begin
  require 'leftright'
rescue LoadError
  puts "Install the 'leftright' gem for sweet output"
end

puts
puts "  LeftRight #{LeftRight::VERSION} (from #{LeftRight::LOCATION})"
puts

if defined? JRUBY_VERSION
  puts "  Using JRuby #{JRUBY_VERSION} (in #{RUBY_VERSION} mode)"
else
  puts "  Using Ruby #{RUBY_VERSION}"
end

class Test::Unit::TestCase
  def under_leftright_run(testcase_str, force_tty = true)
    tested_leftright_lib = File.expand_path(File.dirname(__FILE__) + '/../lib/')
    header = %{
      gem 'test-unit' if RUBY_VERSION > '1.9'
      require 'test/unit'
      $:.unshift '#{tested_leftright_lib}'
      require '#{tested_leftright_lib}/leftright'
    }

    header << %{
      require 'leftright/force_tty'
    } if force_tty # so we can test colors and shit

    # For 'ffi-ncurses' under JRuby
    header << %{
      require 'rubygems'
    } if defined?(RUBY_ENGINE) && RUBY_ENGINE.match('jruby') && defined?(::Gem)

    testcase_str = header + "\n" + testcase_str
    testcase_str = testcase_str.split("\n").map { |l| l.strip }
    testcase_str = testcase_str.reject { |l| l.empty? }.join(';')

    cmd = %[#{RUBY} -e "#{testcase_str}" 2>&1]

    %x[#{cmd}]
  end

  def assert_output(duck)
    if duck.is_a? Regexp
      assert_match duck, strip_color(suite_output)
    else
      assert strip_color(suite_output).include?(duck.to_s)
    end
  end

  def assert_no_output(duck)
    if duck.is_a? Regexp
      assert_no_match duck, strip_color(suite_output)
    else
      assert ! strip_color(suite_output).include?(duck.to_s)
    end
  end

  def strip_color(string)
    string.gsub(/\e\[(?:[34][0-7]|[0-9])?m/, '') # thanks again term/ansicolor
  end

  def debug_out!
    File.open('debug.txt', 'w+') { |f| f << suite_output }
  end
end
