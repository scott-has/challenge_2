class Tax

attr_accessor :taxes, :item_types

	ItemTypes = "item_types"
	ExcludedItems = "excluded_items"
	IncludedItems = "included_items"
	Rate = "rate"
	Taxes = "taxes"
	Parameters = 1
	
	def initialize(tax_config)
		@taxes = tax_config[Taxes]
		@item_types = tax_config[ItemTypes]	
		#validate_taxes
	end
	
	# def validate_taxes		
	# 	@taxes.each do |tax, parameters| 
	# 		puts"tax = #{tax}"
	# 		puts"parameters[ExcludedItems] = #{parameters[ExcludedItems]}"
	# 		parameters[ExcludedItems].nil? 
	# 		validate_excluded_items(parameters[ExcludedItems])
	# 	end
	# end
	
	# def validate_excluded_items(excluded_items)		
	# 	excluded_items.each{|item| raise 'unknown excluded_item' unless @item_types.has? item}		
	# end
	
	def get_item_types (item_description)
		current_item_types =[]
		@item_types.each do |type, keywords|
			keywords.split.each {|keyword| current_item_types << type if item_description.match(Regexp.new(keyword, true) )}			
		end		
		current_item_types.uniq
	end	
	
	def calculate_line_tax (line_total, description)
		line_tax = 0	
		@taxes.each do |tax|
			current_tax = 0

			excluded_items = tax[Parameters][ExcludedItems]
			included_items = tax[Parameters][IncludedItems]
			#puts "excluded_items = #{excluded_items}\tincluded_items =#{included_items}"
			if tax_applies(excluded_items, included_items, description)
				#puts "calculating tax #{tax.inspect} for #{description}"
				line_tax += round_to_05(line_total  * tax[Parameters][Rate]  / 100)
			end
		end	
		return line_tax	
	end
	
	def tax_applies(excluded_items, included_items, item_description)
		#puts "excluded_items = #{excluded_items} included_items = #{included_items}"

		if !included_items.nil?
			if (included_items.keys & get_item_types(item_description)).length > 0
				return true
			else
				return false
			end
			#return true if (included_items.keys & get_item_types(item_description)).length > 0
		end

		return true if excluded_items.nil?

		return false if (excluded_items.keys & get_item_types(item_description)).length > 0

		true

	end	
	
	def round_to_05 (tax)	
		tax = (tax. * 100).to_i
		while tax % 5 != 0
			tax += 1 
		end
		tax / 100.0
	end	
	
end