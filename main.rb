require_relative 'lib/order_processor'
CONFIG_FILE = "config/tax.yaml"
order_processor = OrderProcessor.new(ARGV, CONFIG_FILE)
order_processor.get_order
order_processor.process_order
order_processor.print_reciept

