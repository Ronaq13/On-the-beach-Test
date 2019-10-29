require_relative './setup'

# Entry/Running point of application
begin
  scheduler = Scheduler.new('./my_input.json')
  puts scheduler.tell_order.to_s
rescue Errors::CircularDependency => exception
  puts exception.message
rescue Errors::ItselfDependent => exception
  puts exception.message
end
