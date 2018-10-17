require 'minitest/autorun'
require_relative '../lib/../lib/string_calculator'

describe StringCalculator do
  before do
    @string_calculator = StringCalculator.new
  end

  describe 'when asked about cheeseburgers' do
    it 'must respond positively' do
      @string_calculator.i_can_has_cheezburger?.must_equal 'OHAI!'
    end
  end

  describe 'String Calculator' do
    it 'must respond positively' do
      expect(@string_calculator.add("")).must_equal(0)
    end

    describe 'when there is one argument' do
      it 'must return this argument' do
        expect(@string_calculator.add("1")).must_equal(1)
      end
    end

    describe 'multiple numbers' do
      describe 'when there are two numbers' do
        it 'must add the numbers' do
          expect(@string_calculator.add("1,2")).must_equal(3)
        end
      end

      describe 'when the numbers are separated by commas' do
        it 'must add all the numbers' do
          expect(@string_calculator.add("1,2,3,4")).must_equal(10)
        end
      end

      describe 'when there are newlines between the numbers' do
        it 'must handle this case correctly' do
          expect(@string_calculator.add("1\n2,3")).must_equal(6)
        end
      end

      describe 'when there is a newline in the end' do
        it 'raises an error' do
          proc { @string_calculator.add("1,\n") }.must_raise "Invalid error"
        end

        it 'raises an error' do
          assert_raises "Invalid Error" do
            @string_calculator.add("1,\n")
          end
        end
      end

      describe 'when there is a delimiter defined' do
        it 'must use the new delimiter' do
          expect(@string_calculator.add("//;\n1;2")).must_equal(3)
        end

        it 'must use the ! delimiter' do
          expect(@string_calculator.add("//!\n1!2")).must_equal(3)
        end

        describe 'with delimiters of longer than 1 char' do
          it 'can parse the delimiter correctly' do
            expect(@string_calculator.add("//[***]\n1***2***3")).must_equal(6)
          end

          it 'can parse the delimiter correctly if the delimiter consists of different chars' do
            expect(@string_calculator.add("//[**!]\n1**!2**!3")).must_equal(6)
          end
        end
      end

      describe 'when there are negative numbers' do
        it 'raises an error and shows the negative number' do
          error = assert_raises "Invalid Error" do
            @string_calculator.add("1,2,3,-4")
          end
          assert_match /Negative numbers are not allowed: -4/, error.message
        end

        it 'raises an error and shows multiple negative numbers' do
          error = assert_raises "Invalid Error" do
            @string_calculator.add("1,-2,3,-4")
          end
          assert_match /Negative numbers are not allowed: -2 -4/, error.message
        end
      end

      describe 'when there numbers > 1000' do
        it 'ignores the numbers > 1000' do
          expect(@string_calculator.add("//!\n2!2000")).must_equal(2)
        end
      end

    end
  end
end

