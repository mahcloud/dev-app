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

    @fizzbuzz = FizzBuzz.buzz_range(@start, @finish)
  
    respond_to do |format|
      format.html
      format.json { render json: { :fizzbuzz => @fizzbuzz.to_json } }
    end
  end
end
