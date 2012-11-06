describe "Roman" do
  
  it "returns I for 1" do
    translate(1).should == "I"
  end
  
  it "returns III for 3" do
    translate(3).should == "III"
  end
  
  it "returns IV for 4" do
    translate(4).should == "IV"
  end
  
  it "returns MCDXLIV for 1444" do
    translate(1944).should == "MCMXLIV"
  end
  
  it "returns CMXCIX for 999" do
    translate(499).should == "CDXCIX"
  end
  
  it "returns MDCCCLXXXVIII for 1888" do
    translate(1888).should == "MDCCCLXXXVIII"
  end
  
  it "returns MMXII for 2012" do
    translate(2012).should == "MMXII"
  end
end

ROMAN_DIGITS = {   1 => "I",    5 => "V",  10 => "X", 
                  50 => "L",  100 => "C", 500 => "D",
                1000 => "M",
                   4 => "IV",   9 => "IX",  40 => "XL",
                  90 => "XC", 400 => "CD", 900 => "CM"}
                  
def amounts
  ROMAN_DIGITS.keys.sort.reverse
end
                
def translate(number)
  result = ""
  amounts.each do |x|
    number -= ((number/x).times { result += ROMAN_DIGITS[x] }) * x
  end
  result
end
