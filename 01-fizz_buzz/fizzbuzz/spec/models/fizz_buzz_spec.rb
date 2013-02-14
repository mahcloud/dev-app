require 'spec_helper'

describe FizzBuzz do
  describe "#fizz_one" do
    it "is fizz_one" do
      count = 1
      while count <= 100
        if ((count % 3) == 0) || ((count % 5) == 0)
          response = ""
          if (count % 3) == 0 then response << "Fizz" end
          if (count % 5) == 0 then response << "Buzz" end
          fb = FizzBuzz.fizz_one(count)
          fb.should == response
        else
          fb = FizzBuzz.fizz_one(count)
          fb.should == count
        end

        fb_fb = FizzBuzz.fizz_one(15 * count)
        fb_fb.should == "FizzBuzz"
        if (count % 3) != 0
          fb_b = FizzBuzz.fizz_one(5 * count)
          fb_b.should == "Buzz"
        end
        if (count % 5) != 0
          fb_f = FizzBuzz.fizz_one(3 * count)
          fb_f.should == "Fizz"
        end

        count += 1
      end
    end
  end

  describe "#buzz_range" do
    it "is buzz_range" do
      range = (1..500).to_a
      response_hash = {}
      range.each do |range_item|
        response_hash[range_item] = ""
        if (range_item % 3) == 0 then response_hash[range_item] = "Fizz" end
        if (range_item % 5) == 0 then response_hash[range_item] += "Buzz" end
        if response_hash[range_item] == "" then response_hash[range_item] = range_item end
      end
      response_arr = []
      response_hash.each do |resp_item|
        response_arr << resp_item[1]
      end
      fb = FizzBuzz.buzz_range(1,500)
      fb.should == response_arr
    end
  end
end