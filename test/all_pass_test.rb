require File.dirname(__FILE__) + '/test_helper'

class AllPassTest < Test::Unit::TestCase
  def setup
    @@out ||= under_leftright_run <<-RUBY
      class X < Test::Unit::TestCase
        def test_0
          assert true
        end

        def test_1
          assert true
        end

        def test_2
          assert true
        end
      end
    RUBY
  end

  def test_sequential_dots
    puts @@out
    assert_match /X ...$/, @@out
  end

  def test_test_count
    assert_match /3 tests/, @@out
  end

  def test_summary
    assert_match /all passed/, @@out
  end

  def test_error_count
    assert_no_match /error/, @@out
  end

  def test_failed_count
    assert_no_match /failed/, @@out
  end
end