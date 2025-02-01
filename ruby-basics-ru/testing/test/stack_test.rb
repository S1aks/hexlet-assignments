# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
    @var = 'String'
  end

  def teardown
  end

  def test_add
    @stack.push!(@var)
    assert { @stack.size == 1 }
  end

  def test_delete
    @stack.push!(@var)
    @stack.pop!
    assert { @stack.size == 0 }
  end

  def test_clear
    @stack.push!(@var)
    @stack.push!(@var)
    @stack.clear!
    assert { @stack.size == 0 }
  end

  def test_empty
    assert { @stack.empty? }
  end

  def test_not_empty
    @stack.push!(@var)
    refute { @stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
