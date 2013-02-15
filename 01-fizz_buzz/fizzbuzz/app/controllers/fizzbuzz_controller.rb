class FizzbuzzController < ApplicationController
  def number
    @num = params[:num].to_i
    @num = 15 if @num == 0
    @fizzbuzz = FizzBuzz.fizz_one(@num)

    respond_to do |format|
      format.html
      format.json { render json: { :fizzbuzz => @fizzbuzz.to_json } }
    end
  end

  def range
    @start = params[:start].to_i
    @start = 1 if @start == 0

    @finish = params[:finish].to_i
    @finish = 100 if @finish == 0
    @finish = @start + 1 if @finish <= @start

    redis_val = check_redis(@start, @finish)
    if redis_val.nil?
      partial_redis_val = partial_redis(@start, @finish)
      if partial_redis_val.nil?
        @fizzbuzz = FizzBuzz.buzz_range(@start, @finish)
      else
        first = partial_redis_val[0]
        last = partial_redis_val[1]
        @fizzbuzz = check_redis(first, last)
        if (first - @start) > 0
          if (first - 1) == @start
            @fizzbuzz.unshift(FizzBuzz.fizz_one(@start))
          else
            @fizzbuzz = FizzBuzz.buzz_range(@start, first - 1).concat(@fizzbuzz)
          end
        end
        if (last - @finish) < 0
          if (last + 1) == @finish
            @fizzbuzz << FizzBuzz.fizz_one(@finish)
          else
            @fizzbuzz.concat(FizzBuzz.buzz_range(last + 1, @finish))
          end
        end
      end
      $redis.set(redis_str(@start, @finish), @fizzbuzz.to_s)
    else
      @fizzbuzz = redis_val
    end
  
    respond_to do |format|
      format.html
      format.json { render json: { :fizzbuzz => @fizzbuzz.to_json } }
    end
  end

  private

  def redis_str(start, finish)
    "FizzBuzz:"+start.to_s+".."+finish.to_s
  end

  def check_redis(start, finish)
    redis_val = $redis.get(redis_str(start, finish))
    unless redis_val.nil?
      return eval(redis_val)
    end
  end

  def partial_redis(start, finish)
    length_arr = {}
    redis_keys = $redis.keys('*')
    if redis_keys.length > 0
      redis_keys.each do |key|
        range = key.split('FizzBuzz:')
        first_last = range[1].split('..')
        first = first_last[0].to_i
        last = first_last[1].to_i
        if (first >= start) && (first < finish) && (last <= finish) && (last > start)
          length_arr[last - first] = [first, last]
        end
      end
      if length_arr.length > 0
        length_arr.sort
        return length_arr.first[1]
      end
    end
  end
end
