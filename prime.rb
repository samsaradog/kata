describe "Prime" do
  def factors_right(amount, factors)
    return true if factors.empty?
    ( 0 == (amount % factors.pop)) and factors_right(amount, factors)
  end
  
  LIMIT = 256
  
  it "should return 1 for 1" do
    factor(1).should == [1]
  end
  
  it "should only have factors divisible into the original" do
    (1..LIMIT).each do |x|
      factors_right(x,factor(x)).should == true
    end
  end
  
  it "should not repeat factors" do
    (1..LIMIT).each do |x|
      factors = factor(x)
      factors.should == factors.uniq
    end

  end
  
  it "should include the number in the factors if prime" do
    [181,191,193,211,251].each do |x|
      factors = factor(x)
      factors.pop.should == x
    end
  end
end

def factor(number)
  factors = [1] + sieve((2..number).to_a)
  factors.delete_if { |x| (0 != (number % x))}
end

def sieve(factors)
  return [] unless factor = factors.shift
  [factor] + sieve(factors.delete_if { |x| (0 == (x % factor))})
end
