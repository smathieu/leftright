require File.dirname(__FILE__) + '/test_helper'

class AllErrorTest < Test::Unit::TestCase
  def setup
    @@out ||= under_leftright_run <<-RUBY
      class X < Test::Unit::TestCase
        def test_first_explosion
          raise 'Ka-boom! 0'
        end

        def test_second_explosion
          raise 'Ka-boom! 1'
        end

        def test_third_explosion
          raise 'Ka-boom! 2'
        end
      end
    RUBY
  end

  def test_error_output
    assert_match /X first_explosion/, @@out
    assert_match /RuntimeError/, @@out
    assert_match /Ka-boom! 0/, @@out
  end

  def test_test_count
    assert_match /3 tests/, @@out
  end

  def test_skip_count
    assert_match /2 skipped/, @@out
  end

  def test_error_count
    assert_match /1 error/, @@out
  end

  def test_passed_count
    assert_no_match /passed/, @@out
  end

  def test_failed_count
    assert_no_match /failed/, @@out
  end
end