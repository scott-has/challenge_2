require '../lib/order_processor'

describe @processor do
  before(:each) do
    @processor = OrderProcessor.new(["input_1.txt"],'../config/tax.yaml')
  end

  it "initialized correctly" do
	@processor.args.pop.should eq("input_1.txt")
	@processor.tax.should_not be_nil
	@processor.tax.taxes.length.should eq(2)
  end

  it "reads orders correctly" do	
	@processor.get_order
	@processor.order_lines.length.should eq(3)
	@processor.order_lines[0].price.should eq (12.49)
	@processor.order_lines[1].description.should eq ("music CD")
	@processor.order_lines[2].quantity.should eq (1)
  end

    it "processes orders correctly" do	
	@processor.get_order
	@processor.process_order
	@processor.total_tax.should eq(1.50)
	(@processor.total_tax + @processor.total_items_cost).should eq(29.83)


  end

end
# Sales Taxes: 1.50
# Total: 29.83