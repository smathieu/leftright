require File.dirname(__FILE__) + '/test_helper'

class PassPassErrorTest < Test::Unit::TestCase
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
          raise 'Ka-boom!'
        end
      end
    RUBY
  end

  def test_sequential_dots
    assert_output /X ..$/
  end

  def test_error_output
    assert_output 'Ka-boom!'
  end

  def test_test_count
    assert_output '3 tests'
  end

  def test_passed_count
    assert_output '2 passed'
  end

  def test_error_count
    assert_output '1 error'
  end

  def test_failed_count
    assert_no_output 'failed'
  end

  def test_skip_count
    assert_no_output 'skipped'
  end
end