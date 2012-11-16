TOTAL = 100
COINS = [25,10,5,1]

VALID_RANGE = (1..(TOTAL-1))
HIGH_RANGE  = (TOTAL..(TOTAL+5))
LOW_RANGE   = (-5..0)

describe "Changer" do
  
  def combine change
    change.inject(:+)
  end
  
  def only_coins change
    (change - COINS).empty?
  end
  
  def block_test_each(range, &block) #block parameter has to go last
    range.each do |amount|
      block.call(changer(amount), amount)
    end
  end
  
  def yield_test_each(range)
    range.each do |amount|
      yield(changer(amount),amount)
    end
  end
  
  def test_each(code,range) #extra parameters go at the end
    range.each do |amount|
      code.call(changer(amount), amount)
    end
  end
  
  context "valid input" do
    
    it "should have change and amount add to a dollar" do
      
      #first with method
      
      def check_total(change,amount)
        combine(change).should == (TOTAL-amount)
      end
      
      test_each(method(:check_total),VALID_RANGE)
      
      #next with a lambda
      
      check_total = (lambda { |change,amount| combine(change).should == (TOTAL-amount)})
      
      test_each(check_total,VALID_RANGE)
      
      #next with a Proc
      
      check_total = Proc.new do |change,amount|
        combine(change).should == (TOTAL-amount)
      end
      
      test_each(check_total,VALID_RANGE)

      #last with a block - notice that the extra variable comes before the block
      
      block_test_each VALID_RANGE do |change, amount|
         combine(change).should == (TOTAL-amount)
       end
    end

    it "should give change in quarters, dimes, nickels and pennies" do
      block_test_each VALID_RANGE do |change| #don't like ignoring the second parameter
        only_coins(change).should == true
      end 
      # (1..99).each do |x|
      #   change = changer(x)
      #   only_coins(change).should == true
      # end
    end
  end
  
  context "bad input" do
    
    it "give back everything for amounts >= a dollar" do
      
      check_high = (lambda do |change,amount|
        combine(change).should == amount
        change.size.should == 1
      end)
      
      test_each(check_high,HIGH_RANGE)
      
      block_test_each HIGH_RANGE do |change,amount|
        combine(change).should == amount
        change.size.should == 1
      end
      # (100..105).each do |x|
      #   change = changer(x)
      #   combine(change).should == x
      #   change.size.should == 1
      # end
    end

    it "should give an error for an amount <= zero" do
      
      check_low = (lambda {true})
      
      lambda {test_each(check_low,LOW_RANGE)}.should raise_error(RuntimeError)
      
      LOW_RANGE.each do |x|
        lambda {changer(x)}.should raise_error(RuntimeError)
      end

    end
  end
  
end

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
