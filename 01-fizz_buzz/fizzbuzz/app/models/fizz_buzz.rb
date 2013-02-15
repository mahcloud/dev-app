class FizzBuzz
  def self.fizz_one(num)
    if (num % 3) == 0 then return "Fizz" end
    if (num % 5) == 0 then return "Buzz" end
    if (num % 15) == 0 then return "FizzBuzz" end
    num
  end

  def self.buzz_range(start, finish)
    redis_str = "FizzBuzz:"+start.to_s+".."+finish.to_s
    fizzbuzz = $redis.get(redis_str)
    if fizzbuzz.nil?
      fizzbuzz = []
      while start <= finish
        fizzbuzz << fizz_one(start)
        start += 1
      end
      $redis.set(redis_str, fizzbuzz.to_s)
    else
      fizzbuzz = eval(fizzbuzz.to_s)
    end
    fizzbuzz
  end
end