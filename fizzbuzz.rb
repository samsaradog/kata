describe "FizzBuzz" do
  
  it "should return 1 for 1" do
    fizzbuzz(1).should == 1
  end
  
  it "should return Fizz for 3" do
    fizzbuzz(3).should == "Fizz"
  end
  
  it "should return Buzz for 5" do
    fizzbuzz(5).should == "Buzz"
  end
  
  it "should return FizzBuzz for 15" do
    fizzbuzz(15).should == "FizzBuzz"
  end
  
  it "should return 92 for 92" do
    fizzbuzz(92).should == 92
  end
  
  it "should return FizzBuzz for 375" do
    fizzbuzz(375).should == "FizzBuzz"
  end
  
  it "should throw an error for < 0" do
    lambda { fizzbuzz(-1) }.should raise_error
  end
end

def fizzbuzz(number)
  raise RuntimeError if ( 0 > number )
  return "FizzBuzz"  if ( 0 == (number % 15))
  return "Fizz"      if ( 0 == (number % 3))
  return "Buzz"      if ( 0 == (number % 5))
  number
end
