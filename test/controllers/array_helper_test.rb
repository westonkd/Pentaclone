require 'test_helper'

class ArrayHelperTest < ActionController::TestCase

  def rand_array(size)
    Array.new(size){Array.new(size){rand(0..9)}}
  end

  test "sets quadrant one correctly" do
    new_quadrant = ArrayHelper.new(rand_array(3))
    a = ArrayHelper.new(rand_array(6))
    a.set_quad_one(new_quadrant)
    b = ArrayHelper.new(a.get_quad_one)

    assert new_quadrant.array == b.array
  end

  test "sets quadrant two correctly" do
    new_quadrant = ArrayHelper.new(rand_array(3))
    a = ArrayHelper.new(rand_array(6))
    a.set_quad_two(new_quadrant)
    b = ArrayHelper.new(a.get_quad_two)

    assert new_quadrant.array == b.array
  end

  test "sets quadrant three correctly" do
    new_quadrant = ArrayHelper.new(rand_array(3))
    a = ArrayHelper.new(rand_array(6))
    a.set_quad_three(new_quadrant)
    b = ArrayHelper.new(a.get_quad_three)

    assert new_quadrant.array == b.array
  end

  test "sets quadrant four correctly" do
    new_quadrant = ArrayHelper.new(rand_array(4))
    a = ArrayHelper.new(rand_array(8))
    a.set_quad_four(new_quadrant)
    b = ArrayHelper.new(a.get_quad_four)

    assert new_quadrant.array == b.array
  end

  test "rotates quadrants left" do
    a = ArrayHelper.new(rand_array(6))
    a.out
    puts "\n"
    a.rotate_quad_one false
    a.out
  end

  test "rotates quadrants right" do
    a = ArrayHelper.new(rand_array(6))
    a.out
    puts "\n"
    a.rotate_quad_one
    a.out
  end
end
