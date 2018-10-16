class StringCalculator
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def add numbers
    return 0 if numbers.empty?
    raise "Invalid error"  if comma_followed_by_newline?(numbers)

    dilimeter = parse_dilimeter(numbers)
    numbers_array = if dilimeter
                      rest_of_text(numbers).split(/[\n#{dilimeter}]/)
                    else
                      numbers.split(/[\n,]/)
                    end

    return numbers_array.map{ |x| x.to_i}.reduce(:+)
  end


  def comma_followed_by_newline?(numbers)
    /,\n/.match(numbers)
  end

  def parse_dilimeter(numbers)
    /(?<=\/\/)./.match(numbers)
  end

  def rest_of_text(numbers)
    /(?<=\/\/\W).*$/.match(numbers).post_match
  end

end
