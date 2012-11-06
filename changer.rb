describe "Changer" do
  
  def combine amount, change
    change.inject(amount,:+)
  end
  
  def only_coins change
    (change - [1,5,10,25]).empty?
  end
  
  it "should have change and amount add to a dollar" do
    (1..99).each do |x|
      change = changer(x)
      combine(x, change).should == 100
    end
  end
  
  it "should give change in quarters, dimes, nickels and pennies" do
    (1..99).each do |x|
      change = changer(x)
      only_coins(change).should == true
    end
  end
  
  it "give back everything for amounts >= a dollar" do
    (100..105).each do |x|
      change = changer(x)
      combine(0,change).should == x
      change.size.should == 1
    end
  end
  
  it "should give an error for an amount <= zero" do
    (-5..0).each do |x|
      lambda {changer(x)}.should raise_error
    end
    
  end
  
end

TOTAL = 100
COINS = [25,10,5,1]

def changer amount
  raise RuntimeError if ( amount <= 0 )
  return [amount] if ( amount >= TOTAL )

  result = []
  returned = (TOTAL - amount)
  COINS.each do |x|
    returned -= ( (returned/x).times { result.push(x)}) * x
  end
  result
end
