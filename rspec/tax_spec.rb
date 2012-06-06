require '../lib/tax'
require 'yaml'
describe @tax do
  before(:each) do
  @tax = Tax.new(YAML.load_file('../config/tax.yaml'))
  end

  it "initailizes correctly" do
  	(@tax.taxes.keys & ["sales", "import"]).length.should eq(2)
	(@tax.item_types.keys & %w{books food medical_products imported}).length.should eq(4)
	#puts @tax.taxes["sales"].inspect
	#puts @tax.taxes["import"].inspect
	@tax.taxes["sales"]["included_items"].should be_nil
	@tax.taxes["import"]["excluded_items"].should be_nil
  end

    it "assigns item type correctly" do
    	result = @tax.get_item_types ("imported somthing")
    	result.join.should eq("imported")
    	result = @tax.get_item_types ("book")
    	result.join.should eq("books")

  end

      it "assigns item types correctly" do
    	result = @tax.get_item_types ("imported chocolate heartache somthing")
    	result.length.should eq(3) 
    	result.include?("imported").should be_true
    	result.include?("food").should be_true  
    	result.include?("medical_products").should be_true   	
  end

    it "calculates import tax correctly" do
    	result = @tax.calculate_line_tax(100.00, "imported somthing")
    	result.should eq(15.00)
  end

       it "applies exclusions correctly" do
       	result = @tax.tax_applies({"books" => nil}, nil, "book")    
    	result.should be_false
  end

      it "applies inclusions correctly" do
       	result = @tax.tax_applies(nil,  {"imported" => nil}, "imported something")    
    	result.should be_true
  end

      it "calculates book tax correctly" do
    	result = @tax.calculate_line_tax(100.00, "book")
    	result.should eq(0)
  end

      it "rounds correctly" do
    		result = @tax.round_to_05(100.01)
   			result.should eq(100.05)
 	 end

      it "calculates rounded sales tax correctly" do
    		result = @tax.calculate_line_tax(101.11, "sales taxable somthing")
   			result.should eq(10.15)
 	 end

      it "calculates sales tax correctly" do
    	result = @tax.calculate_line_tax(100.00, "bottle of gin")
    	result.should eq(10.00)
  end


end
