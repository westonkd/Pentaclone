  class ArrayHelper
    attr_accessor :array, :size, :quad_size

    def initialize(array)
      @array = array
      @size = array.length
      @quad_size = array.length / 2
    end

    def out
      for r in 0..@array.length - 1
        for c in 0..@array.length - 1
          print c + 1 == @quad_size ? "#{@array[c][r]}|" : "#{@array[c][r]} "
        end
        if r + 1 == @quad_size
          print "\n"
          (@size * 2 - 1).times do
            print '-'
          end
        end
        print "\n"
      end
    end

    def rotate_quad_one(clockwise = true)
      quad = get_quad_one.transpose

      if !clockwise
        quad = quad.map { |r| r.reverse }
      else
        temp = Array.new(quad.length){Array.new(quad.length){'-'}}
        for r in 0..temp.length - 1
          for c in 0..temp.length - 1
            temp[temp.length - c - 1][r] = quad[c][r]
          end
        end
        quad = temp
      end

      set_quad_one(ArrayHelper.new(quad))
    end

    def rotate_quad_two(clockwise = true)
      quad = get_quad_two.transpose

      if !clockwise
        quad = quad.map { |r| r.reverse }
      else
        temp = Array.new(quad.length){Array.new(quad.length){'-'}}
        for r in 0..temp.length - 1
          for c in 0..temp.length - 1
            temp[temp.length - c - 1][r] = quad[c][r]
          end
        end
        quad = temp
      end

      set_quad_two(ArrayHelper.new(quad))
    end

    def rotate_quad_three(clockwise = true)
      quad = get_quad_three.transpose

      if !clockwise
        quad = quad.map { |r| r.reverse }
      else
        temp = Array.new(quad.length){Array.new(quad.length){'-'}}
        for r in 0..temp.length - 1
          for c in 0..temp.length - 1
            temp[temp.length - c - 1][r] = quad[c][r]
          end
        end
        quad = temp
      end

      set_quad_three(ArrayHelper.new(quad))
    end

    def rotate_quad_four(clockwise = true)
      quad = get_quad_four.transpose

      if !clockwise
        quad = quad.map { |r| r.reverse }
      else
        temp = Array.new(quad.length){Array.new(quad.length){'-'}}
        for r in 0..temp.length - 1
          for c in 0..temp.length - 1
            temp[temp.length - c - 1][r] = quad[c][r]
          end
        end
        quad = temp
      end

      set_quad_four(ArrayHelper.new(quad))
    end

    def get_quad_four
      ret_val = Array.new(@quad_size){Array.new(@quad_size){'-'}}

      new_r, new_c = 0, 0

      for r in @quad_size..@size - 1
        for c in @quad_size..@size - 1
          ret_val[new_c][new_r] = @array[c][r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      ret_val
    end

    def get_quad_three
      ret_val = Array.new(@quad_size){Array.new(@quad_size){'-'}}

      new_r, new_c = 0, 0

      for r in @quad_size..@size - 1
        for c in 0..@quad_size - 1
          ret_val[new_c][new_r] = @array[c][r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      ret_val
    end

    def get_quad_two
      ret_val = Array.new(@quad_size){Array.new(@quad_size){'-'}}

      new_r, new_c = 0, 0

      for r in 0..@quad_size - 1
        for c in 0..@quad_size - 1
          ret_val[new_c][new_r] = @array[c][r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      ret_val
    end

    def get_quad_one
      ret_val = Array.new(@quad_size){Array.new(@quad_size){'-'}}

      new_r, new_c = 0, 0

      for r in 0..@quad_size - 1
        for c in @quad_size..@size - 1
          ret_val[new_c][new_r] = @array[c][r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      ret_val
    end

    def set_quad_one(array_helper)
      return nil if array_helper.size != @quad_size
      new_r, new_c = 0, 0

      for r in 0..@quad_size - 1
        for c in @quad_size..@size - 1
          @array[c][r] = array_helper.array[new_c][new_r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      @array
    end

    def set_quad_two(array_helper)
      return nil if array_helper.size != @quad_size
      new_r, new_c = 0, 0

      for r in 0..@quad_size - 1
        for c in 0..@quad_size - 1
          @array[c][r] = array_helper.array[new_c][new_r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      @array
    end

    def set_quad_three(array_helper)
      return nil if array_helper.size != @quad_size
      new_r, new_c = 0, 0

      for r in @quad_size..@size - 1
        for c in 0..@quad_size - 1
          @array[c][r] = array_helper.array[new_c][new_r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      @array
    end

    def set_quad_four(array_helper)
      return nil if array_helper.size != @quad_size
      new_r, new_c = 0, 0

      for r in @quad_size..@size - 1
        for c in @quad_size..@size - 1
          @array[c][r] = array_helper.array[new_c][new_r]
          new_c += 1
        end
        new_c = 0
        new_r += 1
      end

      @array
    end
  end