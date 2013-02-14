require 'spec_helper'

describe "routes for Fizzbuzz" do
  it "routes to fizzbuzz/number" do
    { :get => "/fizzbuzz/number" }.should be_routable
  end
  it "routes to fizzbuzz/range" do
    { :get => "/fizzbuzz/range" }.should be_routable
  end
end