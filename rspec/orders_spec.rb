require '../lib/order'

describe @args do
  before(:each) do
   @args = ["input_1.txt"]
  end

  it "reads from file" do
  	order_lines = Order::OrderReader.read_order(@args)
  	order_lines.length.should eq(3)
  	order_lines[0].price.should eq (12.49)
	order_lines[1].description.should eq ("music CD")
	order_lines[2].quantity.should eq (1)
  end

  it "reads from console" do  #need to enter the same lines as in file followed by quit
  	order_lines = Order::OrderReader.read_order(nil)
  	order_lines.length.should eq(3)
	order_lines[0].price.should eq (12.49)
	order_lines[1].description.should eq ("music CD")
	order_lines[2].quantity.should eq (1)
  end



end
