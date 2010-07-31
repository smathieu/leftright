require File.dirname(__FILE__) + '/test_helper'

class PassPassErrorTest < Test::Unit::TestCase
  def setup
    @out = under_leftright_run <<-RUBY
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
    assert_match /X ..$/, @out
  end

  def test_error_output
    assert_match /Ka-boom!/, @out
  end

  def test_test_count
    assert_match /3 tests/, @out
  end

  def test_passed_count
    assert_match /2 passed/, @out
  end

  def test_error_count
    assert_match /1 error/, @out
  end

  def test_failed_count
    assert_no_match /failed/, @out
  end

  def test_skip_count
    assert_no_match /skipped/, @out
  end
end