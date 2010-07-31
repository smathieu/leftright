require File.dirname(__FILE__) + '/test_helper'

class AllPassTest < Test::Unit::TestCase
  def suite_output
    @@_suite_output ||=under_leftright_run <<-RUBY
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
    assert_output /X ...$/
  end

  def test_test_count
    assert_output '3 tests'
  end

  def test_summary
    assert_output 'all passed'
  end

  def test_error_count
    assert_no_output 'error'
  end

  def test_failed_count
    assert_no_output 'failed'
  end
end