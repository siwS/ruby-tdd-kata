class StringCalculator
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def add(numbers)
    return 0 if numbers.empty?
    raise "Invalid error"  if comma_followed_by_newline?(numbers)

    long_delimiter = long_delimiter(numbers)
    if long_delimiter != nil && long_delimiter.size > 0
      delimiter = long_delimiter[0]
    else
      delimiter = parse_delimiter(numbers)
    end
    numbers_array = calculate_numbers_array(delimiter, numbers)
    numbers_array = numbers_array.map { |x| x.to_i }

    negative_numbers = numbers_array.select { |x| x < 0 }
    raise "Negative numbers are not allowed: #{negative_numbers.join(" ")}"  if negative_numbers.any?

    numbers_less_than_1000 = numbers_array.select { |x| x < 1000 }
    sum = numbers_less_than_1000.map{ |x| x.to_i }.reduce(:+)
    return sum
  end


  private def comma_followed_by_newline?(numbers)
    /,\n/.match(numbers)
  end

  private def parse_delimiter(numbers)
    /(?<=\/\/)./.match(numbers)
  end

  private def rest_of_text(numbers)
    /(?<=\/\/\W).*$/.match(numbers).post_match
  end

  private def calculate_numbers_array(delimiter, numbers)
    if delimiter
      rest_of_text(numbers).split(/[\n#{delimiter}]/)
    else
      numbers.split(/[\n,]/)
    end
  end

  private def long_delimiter(numbers)
    /(?<=\/\/\[).+?(?=\]\n)/.match(numbers)
  end

end
