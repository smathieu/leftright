require File.dirname(__FILE__) + '/test_helper'

class AllFailTest < Test::Unit::TestCase
  def suite_output
    @@_suite_output ||= under_leftright_run <<-RUBY
      class X < Test::Unit::TestCase
        def test_0
          assert false
        end

        def test_1
          assert false
        end

        def test_2
          assert false
        end
      end
    RUBY
  end

  def test_error_output
    assert_output '<false> is not true'
  end

  def test_test_count
    assert_output '3 tests'
  end

  def test_skip_count
    assert_output '2 skipped'
  end

  def test_fail_count
    assert_output '1 failed'
  end

  def test_error_count
    assert_no_output 'error'
  end

  def test_passed_count
    assert_no_output 'passed'
  end
end