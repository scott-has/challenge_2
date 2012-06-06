class Tax

	ItemTypes = "item_types"
	ExcludedItems"excluded_items"
	
	def self.validate_excluded_items(items, excluded_items)		
		exluded_items.each{|item| raise 'unknown excluded_item' unless items.has_key? item}		
	end
	
	def self.validate_taxes(tax_configuration)
		item_types = tax_configuration[ItemTypes]		
		tax_configuration["taxes"].each{|tax| validate_excluded_items(items, tax[ExcludedItems])
	end

	
	def self.get_item_types (item_types, item_description)
		current_item_types =[]
		item_types .each do |type|	
			type.each {|keyword| current_item_types << type if item_description.match(Regexp.new(keyword, true) )}			
		end		
		item_types.uniq
	end	
	
	def self.round_tax (tax)	
		tax = tax * 100
		while tax % 5 != 0 {tax += 1}
		tax / 100
	end
	
	def self.calculate_line_tax (line_total, description)
		
		if (tax[:exclusions].length = 0) || (!tax[:exclusions].include?( get_item_types line[:description] ))
			round_tax( line_total  * tax[:rate]  / 100)
		end
		
	end
	
	
	
	
end