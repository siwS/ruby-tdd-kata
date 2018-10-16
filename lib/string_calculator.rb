class StringCalculator
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def add numbers
    return 0 if numbers.empty?
    raise "Invalid error"  if comma_followed_by_newline?(numbers)

    dilimeter = parse_dilimeter(numbers)
    numbers_array = calculate_numbers_array(dilimeter, numbers)
    negative_numbers = numbers_array.select { |x| x.to_i < 0 }
    raise "Negative numbers are not allowed: #{negative_numbers.join(" ")}"  if negative_numbers.any?

    sum = numbers_array.map{ |x| x.to_i}.reduce(:+)
    return sum
  end


  private def comma_followed_by_newline?(numbers)
    /,\n/.match(numbers)
  end

  private def parse_dilimeter(numbers)
    /(?<=\/\/)./.match(numbers)
  end

  private def rest_of_text(numbers)
    /(?<=\/\/\W).*$/.match(numbers).post_match
  end

  private def calculate_numbers_array(dilimeter, numbers)
    if dilimeter
      rest_of_text(numbers).split(/[\n#{dilimeter}]/)
    else
      numbers.split(/[\n,]/)
    end
  end

end
