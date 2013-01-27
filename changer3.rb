DOLLAR = 100
COIN_LIMITS = { 25 => 4, 10 => 3, 5 => 2, 1 => 5 }

describe "changer" do
  
  context "bad input" do
    it "throws an error when given a negative amount" do
      lambda { changer(-1) }.should raise_error(RuntimeError)
    end
    
    it "gives back everything for amounts >= $1" do
      (DOLLAR..(DOLLAR+5)).each do |x|
        changer(x).should == x
      end
    end
    
  end #context
  
  context "good input" do
    
    def only_coins handful
      (handful - COIN_LIMITS.keys).empty?
    end
    
    (1..99).each do |amount|
      
      change_total = (DOLLAR - amount)
      
      it "returns the right sum for #{change_total}" do
        changer(amount).inject(:+).should == change_total
      end
      
      it "only uses coins to make up #{change_total}" do
        only_coins(changer(amount)).should == true 
      end
      
      it "uses the right number of coins for #{change_total}" do
        COIN_LIMITS.each { |key,value| changer(amount).count(key).should be < value }
      end
    end
    
  end #context
  
end


def changer amount
  raise RuntimeError if (amount < 0)
  return amount if (amount >= DOLLAR)
  
  returned = (DOLLAR - amount)
  result = []
  
  COIN_LIMITS.each_key do | coin_amount |
    factor = (returned/coin_amount).times { result.push(coin_amount) }
    returned -= factor * coin_amount
  end
  result
end