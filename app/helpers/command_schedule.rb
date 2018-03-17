
class CommandSchedule
    
    def self.schedule
        
        now = DateTime.now
        
        #for test only
        #now = DateTime.new(2017, 7, 6, 9, 0, 0)  
        
        puts "schedule heating operation launched at #{now}"
        
        scheduledOperation = RangeCommand.all
        scheduledOperation.each do |currentOperation|
          #p currentOperation 
          #check if dateTime current correspond to the given range.
          if (currentOperation.inRange?(now)) then
              #take all heaters and applies the command is the current command is not the good one
              #expect if forced equals true
              currentOperation.actuators.each do |currentHeader|
                  if (currentHeader.forced?) then
                    p "operation: #{currentOperation.name}, heater: #{currentHeader.name}, forced, nothing to do"
                  else
                    p "operation: #{currentOperation.name}, heater: #{currentHeader.name}, apply new command #{currentOperation.command}"
                    if (currentHeader.value == currentOperation.command) then
                        p "operation: #{currentOperation.name}, heater: #{currentHeader.name}, nothing to do, command is already set"
                    else
                        send_command(currentHeader, currentHeader.order, currentOperation.command)
                    end
                  end
              end
          end
        end
    end

    def self.send_command(heater, sensor_id, command)
        output = open(ENV['PIPE_NAME'], "w+") # the a for append at the end
        output.puts "#{heater.device.address};#{sensor_id};#{command}"
        output.flush
        output.close
    end
    
end

    
