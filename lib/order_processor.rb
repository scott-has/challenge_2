require_relative 'tax'
require_relative 'order'
require 'yaml'

class OrderProcessor
	

	attr_accessor :order_lines, :total_tax, :total_items_cost, :args, :tax

	
	def initialize (args, config_file)
		@tax = Tax.new(YAML.load_file(config_file))
		@args = args
	end	
	
	def get_order		
		@order_lines = Order::OrderReader.read_order(@args)
	end
	
	def process_order
		@total_tax = 0
		@total_items_cost = 0
		@order_lines.each do |line|
			@total_tax += line.calculate_line_tax (@tax)	
			@total_items_cost += line.total
		end	
	end
		
	def print_reciept
		@order_lines.each do |line|
			line.print_order_line
		end	
		print_tax_total	
		print_order_total
	end	
	
	def print_tax_total
		puts "Sales Taxes: #{sprintf( "%0.02f",@total_tax)}"
	end
	
	def print_order_total
		puts "Total: #{sprintf( "%0.02f", @total_tax + @total_items_cost)}"
	end

end

