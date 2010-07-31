require File.dirname(__FILE__) + '/test_helper'

class AllErrorTest < Test::Unit::TestCase
  def suite_output
    @@_suite_output ||= under_leftright_run <<-RUBY
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
    assert_output 'X first_explosion'
    assert_output 'RuntimeError'
    assert_output 'Ka-boom! 0'
  end

  def test_test_count
    assert_output '3 tests'
  end

  def test_skip_count
    assert_output '2 skipped'
  end

  def test_error_count
    assert_output '1 error'
  end

  def test_passed_count
    assert_no_output 'passed'
  end

  def test_failed_count
    assert_no_output 'failed'
  end
end