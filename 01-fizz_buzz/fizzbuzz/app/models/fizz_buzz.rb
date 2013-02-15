class FizzBuzz
  def self.fizz_one(num)
    if (num % 15) == 0 then return "FizzBuzz" end
    if (num % 3) == 0 then return "Fizz" end
    if (num % 5) == 0 then return "Buzz" end
    num
  end

  def self.buzz_range(start, finish)
    fizzbuzz = []
    while start <= finish
      fizzbuzz << fizz_one(start)
      start += 1
    end
    fizzbuzz
  end
end