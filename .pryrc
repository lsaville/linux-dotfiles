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

## The auditlog must be explicitly enabled
#Pry.config.auditlog_enabled = true           # default: false
#
## Path to audit log destination and optional file mode
#Pry.config.auditlog_file = '/home/gumption/LOGTOWN'   # default: '/dev/null'
#Pry.config.auditlog_file_mode = 0644         # default: 0600
#
## We log both input and output by default
#Pry.config.auditlog_log_input = true        # default: true
#Pry.config.auditlog_log_output = true       # default: true
#
## Set all config values *before* requiring the plugin
#require 'pry-auditlog'
