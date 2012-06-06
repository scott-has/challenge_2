module Order
	
	class LineItem
		attr_accessor :price, :quantity, :description, :item_types, :tax, :total	

		def initialize(quantity, description, price)
			@quantity = quantity
			@description = description
			@price = price
			@tax = 0
			@total = @quantity * @price
		end
		
		def  calculate_line_tax (tax_object)			
			@tax = tax_object.calculate_line_tax(@total, @description)
		end
				
		def  print_order_line			
			@description = fix_jeromes_typos (@description)
			puts "#{@quantity} #{@description}: #{@price} "
		end
		
		def fix_jeromes_typos (str)
			typos = str.match /(.+)(imported )(.+)/i
			typos.nil? ? str : typos[2] + typos[1] + typos[3]			
		end
	end
	
################################################	


	class OrderReader
		
		def self.create_order_line (line)
			regex = /(\d+)(.+)at (\d+\.\d{2})/i
			arr = regex.match(line) 
			LineItem.new(arr[1].to_i, arr[2].strip, arr[3].to_f) if arr
		end
		
		def self.read_order(args)
			if args.nil? || args.length == 0 
				lines = read_from_console
			else
				lines = read_from_file(args)
			end
			raise "invalid order" unless lines			
			lines.map{|line| create_order_line(line)}
			lines.compact
		end
	
		def self.read_from_file(args)
			order_lines = []
			file = File.new(args.shift)
			file.each {|line| order_lines << line}
			order_lines
		end
		
		def self.read_from_console
			order_lines = []
			puts("Enter order lines, type <quit> to terminate input")
			begin 
				line = STDIN.gets.chomp!
				order_lines  << line if line != "quit"
			end	while line != "quit"
		end
	end

	
	################################################	

	class Order
		
	# 	def self.parse_line (line)
	# 		regex = /(\d+)(.+)at (\d+\.\d{2})/i
	# 		arr = regex.match(line) 
	# 		parsed_line = LineItem.new(arr[1].to_i, arr[2].strip, arr[3].to_f) if arr
	# 	end
		
	# 	def self.read_order(args)
	# 		args.nil? || args.length == 0 ? read_from_console : read_from_file(args)
	# 	end
	
	# 	def self.read_from_file(args)
	# 		file = File.new(args.pop)
	# 		file.each {|line| order_lines << line}
	# 		order_lines
	# 	end
		
	# 	def self.read_from_console
	# 		begin 
	# 			order_lines  << gets().chomp
	# 		end	while line.length > 0
	# 		order_lines
	# 	end
	 end
	
	
end