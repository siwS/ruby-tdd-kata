class StringCalculator
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def add numbers
    return 0 if numbers.empty?
    raise "Invalid error"  if comma_followed_by_newline?(numbers)

    numbers_array = numbers.split(/[\n,]/)
    return numbers_array.map{ |x| x.to_i}.reduce(:+)
  end


  def comma_followed_by_newline?(numbers)
    /,\n/.match(numbers)
  end
end
