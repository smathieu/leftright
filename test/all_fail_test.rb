require File.dirname(__FILE__) + '/test_helper'

class AllFailTest < Test::Unit::TestCase
  def setup
    @out = under_leftright_run <<-RUBY
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
    assert_match /<false> is not true/, @out
  end

  def test_test_count
    assert_match /3 tests/, @out
  end

  def test_skip_count
    assert_match /2 skipped/, @out
  end

  def test_fail_count
    assert_match /1 failed/, @out
  end

  def test_error_count
    assert_no_match /error/, @out
  end

  def test_passed_count
    assert_no_match /passed/, @out
  end
end