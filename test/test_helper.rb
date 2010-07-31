require 'test/unit'
require 'rake'

begin
  require 'leftright'
rescue LoadError
  puts "Install the 'leftright' gem for sweet output"
end

class Test::Unit::TestCase
  def under_leftright_run(testcase_str, force_tty = true)
    tested_leftright_lib = File.expand_path(File.dirname(__FILE__) + '/../lib/')
    header = %{
      require 'test/unit'
      $:.unshift '#{tested_leftright_lib}'
      require 'leftright'
    }

    header << %{
      require 'leftright/force_tty'
    } if force_tty # so we can test colors and shit

    testcase_str = header + "\n" + testcase_str
    testcase_str = testcase_str.split("\n").map { |l| l.strip }
    testcase_str = testcase_str.reject { |l| l.empty? }.join(';')

    cmd = %[#{RUBY} -e "#{testcase_str}" 2>&1]

    %x[#{cmd}]
  end
end