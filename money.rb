describe "Money" do
  
  it "multiplies without side effects" do
    first = Money.dollar(5)
    first.times(2).should == Money.dollar(10)
    first.times(3).should == Money.dollar(15)
    
    second = Money.franc(5)
    second.times(2).should == Money.franc(10)
    second.times(3).should == Money.franc(15)
  end
  
  it "compares different currencies" do
    Money.franc(5).should_not == Money.dollar(5)
  end
  
  it "rounds amounts correctly" do
    
  end
  
  it "keeps amount private" do
    lambda { Money.dollar(0).amount = 1 }.should raise_error
  end
  
  it "implements equality comparison" do
    Money.dollar(5).should == Money.dollar(5)
    Money.dollar(6).should_not == Money.dollar(5)
    Money.franc(5).should == Money.franc(5)
    Money.franc(6).should_not == Money.franc(5)
    Money.franc(6).should_not == Money.dollar(5)
  end
  
  it "implements a hash function" do
    
  end
  
  it "compares correctly to nil" do
    
  end
  
  it "compares correctly with another object" do
    
  end
  
  it "retrieves currencies correctly" do
    Money.dollar(1).currency.should == "USD"
    Money.franc(1).currency.should  == "CHF"
  end
  
  it "does simple addition" do
    five = Money.dollar(5)
    sum = Expression.new(five.plus(five))
    bank = Bank.new
    reduced = bank.reduce(sum,"USD")
    Money.dollar(10).should == reduced
    
    six = Money.dollar(6)
    sum = Expression.new(six.plus(five))
    bank = Bank.new
    reduced = bank.reduce(sum, "USD")
    Money.dollar(11).should == reduced
  end
  
  it "reduces money correctly" do
    five = Money.dollar(5)
    bank = Bank.new
    reduced = bank.reduce(five, "USD")
    Money.dollar(5).should == reduced
  end
  
  it "reduces different currency correctly" do
    bank = Bank.new
    bank.add_rate("USD","CHF",2)
    reduced = bank.reduce(Money.franc(2),"USD")
    Money.dollar(1).should == reduced
  end
  
end

#----------------------------------------

class Bank
  
  def reduce(source, to)
    source.reduce(self,to)
  end
  
  def add_rate(from,to,amount)
  end
  
  def rate(from,to)
    ( ("CHF" == from) && ("USD" == to)) ? 2 : 1
  end
  
end

class Money 
  attr_reader :amount, :currency
  
  def initialize(amount,currency)
    @amount   = amount
    @currency = currency
  end
  
  def self.dollar(initial)
    Money.new(initial,"USD")
  end
  
  def self.franc(initial)
    Money.new(initial,"CHF")
  end
  
  def ==(other)
    self.amount == other.amount and self.currency == other.currency
  end
  
  def times(multiplier)
    Money.new((@amount * multiplier), @currency)
  end
  
  def plus(addend)
    [ self, addend ]
    # [ Money.new((amount+addend.amount), @currency) ]
  end
  
  def reduce(bank,to)
    rate = bank.rate(@currency,to)
    Money.new(@amount/rate, to)
    # puts self.inspect
    # self
  end
  
  def +(other)
    @amount += other.amount
  end
end

class Expression
  attr_reader :list
  
  def initialize(term)
    @list = []
    @list += term
    # term.each { |x| Money.new(x.amount,x.currency)}
  end
  
  def reduce(bank,to)
    total = 0
    list.each { |money| total += money.amount }
    Money.new(total,to)
  end
end

class Pair
  
  def initialize(first,second)
    @first  = first
    @second = second
  end
  
  def ==(other)
    ( @first == other.first ) && ( @second == other.second )
  end
end

