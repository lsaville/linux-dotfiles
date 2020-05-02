require 'json'

Pry::Commands.block_command "persist", "write big stuff to json file" do |input|
  input = if input
    target.eval(input)
  else
    context[:pry_instance].last_result
  end

  File.open("/tmp/pry-output.json", "w") { |f| f.write(input.to_json) }

  output.puts "Killed it..."
end
